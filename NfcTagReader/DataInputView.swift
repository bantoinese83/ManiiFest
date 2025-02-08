import SwiftUI

struct DataInputView: View {
    @ObservedObject var nfcManager: NFCManager
    @Binding var urlToWrite: String

    var body: some View {
        VStack {
            TextField("Enter URL", text: $urlToWrite)
                .padding()
                .border(Color(.systemGray5), width: 1)
                .padding(.horizontal)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .onChange(of: urlToWrite) { _, newValue in
                    nfcManager.dataToWrite = [mimeTypeKey: "text/plain", "payload": newValue]
                }
        }
    }
}
