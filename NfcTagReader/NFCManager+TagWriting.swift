import SwiftUI
import CoreNFC
import os.log

extension NFCManager {
    // MARK: - Writing Data to Tag
    func writeDataToTag(tag: NFCNDEFTag) {
        showProgressView = true
        let ndefMessage = createNdefMessage(for: selectedDataType)

        tag.writeNDEF(ndefMessage) { [weak self] (error: Error?) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let error = error {
                    os_log("Error writing to tag: %@", log: .default, type: .error, String(describing: error))
                    self.errorMessage = "Write Failed: \(error.localizedDescription)"
                    self.presentAlert = true
                    self.updateMessage("Write Failed")
                } else {
                    os_log("Successfully wrote to tag!", log: .default, type: .info)
                    self.updateMessage("✨ ManiiFest Set! ✨")
                    self.urlTracker.addURL(url: self.urlToWrite) // Record URL write
                }
                self.stopNFCWriteSession()
                self.provideHapticFeedback(style: error == nil ? .success : .error)
            }
        }
    }
}
