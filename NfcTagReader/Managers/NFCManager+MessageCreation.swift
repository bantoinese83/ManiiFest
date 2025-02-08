import SwiftUI
import CoreNFC
import os.log

extension NFCManager {
    // Function to create NDEF messages for different data types
     func createNdefMessage(for dataType: NFCTagDataType) -> NFCNDEFMessage {
        switch dataType {
        case .url:
            return createURLNdefMessage()
        }
    }

    //URL
    private func createURLNdefMessage() -> NFCNDEFMessage {
        guard let urlString = dataToWrite[payloadKey], let data = urlString.data(using: .utf8) else {
            print("Error: Could not encode URL")
            errorMessage = "Coudln't encode URL"
            presentAlert = true
            return NFCNDEFMessage(records: [])
        }
        // Payload should be UTF8-encoded URL string. Prepend with 0x01 per NFC Forum spec
        let payloadData = Data([0x01]) + data
        let payload = NFCNDEFPayload(
            format: .nfcWellKnown,
            type: "U".data(using: .utf8)!, // RTD_URI type
            identifier: Data(),
            payload: payloadData
        )
        return NFCNDEFMessage(records: [payload])
    }
}
