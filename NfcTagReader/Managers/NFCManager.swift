import SwiftUI
import CoreNFC
import os.log // For proper logging
import AVFoundation

class NFCManager: NSObject, NFCNDEFReaderSessionDelegate, ObservableObject {
    // MARK: - Published Properties

    @Published var tagMessage: String = "Scan or Set your URL" // More Minimal
    @Published var isScanning = false
    @Published var isWriting = false
    var urlToWrite: String = ""
    @Published var presentAlert: Bool = false // To present errors in ContentView
    @Published var selectedDataType: NFCTagDataType = .url // Default selection
    @Published var dataToWrite: [String: String] = [mimeTypeKey: "text/plain", payloadKey: ""] // Data for various tag types
    @ObservedObject var urlTracker = URLTracker() // Add URLTracker instance

    // MARK: - Properties
    weak var delegate: NFCManagerDelegate?
    var nfcSession: NFCNDEFReaderSession?
    var currentTag: NFCNDEFTag?
    @Published var errorMessage: String = "" // Store Error Message

    @Published var showProgressView = false

    // MARK: - Initialization

    override init() {
        super.init()
    }

    // MARK: - NFC Session Management (Reading)

    func startNFCSession() {
        guard NFCNDEFReaderSession.readingAvailable else {
            updateMessage("Device not supported")
            return
        }

        nfcSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcSession?.alertMessage = "Scan to ManiiFest! " // more simple message
        isScanning = true
        showProgressView = true
        tagMessage = "Scanning..."

        nfcSession?.begin()
    }

    func stopNFCSession() {
        nfcSession?.invalidate()
        nfcSession = nil
        isScanning = false
        currentTag = nil
        showProgressView = false
        tagMessage = "Ready"
    }

    // MARK: - NFC Session Management (Writing)

    func startNFCWriteSession() {
        guard NFCNDEFReaderSession.readingAvailable else {
            updateMessage("Device not supported")
            return
        }

        nfcSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcSession?.alertMessage = "Hold near NFC tag" // More generic
        isWriting = true
        showProgressView = true
        tagMessage = "Writing..."
        nfcSession?.begin()
    }

    func stopNFCWriteSession() {
        nfcSession?.invalidate()
        nfcSession = nil
        isWriting = false
        currentTag = nil
        showProgressView = false
        tagMessage = "Ready"
    }

    // MARK: - NFCNDEFReaderSessionDelegate methods
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        isScanning = false
        isWriting = false
        showProgressView = false
        if let readerError = error as? NFCReaderError {
            var errorMessage = "NFC Error" // shortened
            if #available(iOS 13.0, *) {
                switch readerError.code {
                case .readerSessionInvalidationErrorUserCanceled:
                    return // User cancelled
                case .readerSessionInvalidationErrorSessionTimeout:
                    errorMessage = "Session Timeout" // shortened
                case .readerErrorUnsupportedFeature:
                    errorMessage = "Device not supported" // shortened
                default:
                    errorMessage = "Unexpected Error" // shortened
                }
            } else {
                // Handle older iOS versions
                errorMessage = "NFC Error" // shortened
            }

            updateMessage(errorMessage)
            os_log("NFC Session invalidated with error: %@", log: .default, type: .error, error.localizedDescription)
        } else {
            updateMessage("Unexpected Error") // shortened
            os_log("Unexpected NFC Session error: %@", log: .default, type: .error, error.localizedDescription)
        }
        provideHapticFeedback(style: .error)
        DispatchQueue.main.async {
            self.nfcSession = nil
            self.currentTag = nil
        }
    }

    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
         if let tag = tags.first {
             currentTag = tag  // Store the detected tag
             session.connect(to: tag) { [weak self] (error: Error?) in //Prevent Retain Cycle
                 guard let self = self else { return }
                 if let error = error {
                     os_log("Error connecting to tag: %@", log: .default, type: .error, String(describing: error))
                     session.invalidate(errorMessage: "Error connecting to tag")
                     DispatchQueue.main.async {
                         self.isWriting = false
                     }
                     return
                 }

                 // Check if we're in write mode
                 if self.isWriting {
                      DispatchQueue.main.async {
                          session.alertMessage = "Setting ManiiFest... ✨" // shortened
                      }
                      self.writeDataToTag(tag: tag) // Now call writeDataToTag
                  } else {
                     // Read mode, proceed to read the NDEF message
                     tag.readNDEF { [weak self](message: NFCNDEFMessage?, error: Error?) in //Prevent Retain Cycle
                         guard let self = self else { return }
                         if let error = error {
                             os_log("Error reading NDEF: %@", log: .default, type: .error, String(describing: error))
                             session.invalidate(errorMessage: "Error reading NDEF")
                             return
                         }

                         guard let message = message else {
                             session.invalidate(errorMessage: "No ManiiFest found")
                             return
                         }

                         session.invalidate() // Invalidate after processing the tag
                         self.readerSession(session, didDetectNDEFs: [message])
                     }
                 }
             }
         }
     }
}
