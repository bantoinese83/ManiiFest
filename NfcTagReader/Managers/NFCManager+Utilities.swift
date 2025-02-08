import SwiftUI
import CoreNFC
import os.log
import AVFoundation

extension NFCManager {
    // MARK: - Helper Methods

    enum FeedbackStyle {
        case success, error
    }

    func provideHapticFeedback(style: FeedbackStyle) {
        let generator = UINotificationFeedbackGenerator()
        switch style {
        case .success:
            generator.notificationOccurred(.success)
        case .error:
            generator.notificationOccurred(.error)
        }
    }
    private func openURL(url: URL) {
        Task { @MainActor in
            UIApplication.shared.open(url)
        }
    }

    // Refactored History Handling
    func handleTagData(message: String, urlString: String? = nil, dataType: NFCTagDataType) {
        DispatchQueue.main.async { [weak self] in // Capture list to prevent retain cycles
            guard let self = self else { return }
            self.updateMessage(message)
            self.provideHapticFeedback(style: .success)

            if let urlString = urlString, let url = URL(string: urlString) {
                self.openURL(url: url)
            }
        }
    }

    // MARK: - UI Update
     func updateMessage( _ message: String){
         DispatchQueue.main.async { [weak self] in // Capture list to prevent retain cycles
             guard let self = self else { return }
             self.tagMessage = message
             self.delegate?.nfcManager(self, didUpdateMessage: message)
         }
     }
}
