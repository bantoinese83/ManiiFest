import SwiftUI
import CoreNFC
import os.log

extension NFCManager {
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        guard let ndefMessage = messages.first, let record = ndefMessage.records.first else {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.updateMessage("Empty Tag")
            }
            return
        }
        var finalMessage = "Unknown Data Type"
        let detectedDataType: NFCTagDataType = .url // Store detected Data Type

        if record.type.elementsEqual([0x55]), let urlString = String(data: record.payload.dropFirst(3), encoding: .utf8) {
             //URL
             finalMessage = "💖 ManiiFest URL: \(urlString) 💖" // shortened
             self.urlTracker.recordRead(url: urlString) // Record URL read
        } else {
            finalMessage = "Unknown URL"
            self.errorMessage = "Could not read the tag"
            presentAlert = true
        }
        handleTagData(message: finalMessage, dataType: detectedDataType) // pass the type to history
        self.stopNFCSession()

    }
}
