import SwiftUI

struct ContentView: View {
    @ObservedObject var nfcManager = NFCManager()
    @State private var urlToWrite: String = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(systemName: "sparkle") // Sparkle Icon for Nail Salon Vibe
                        .font(.largeTitle)
                        .foregroundColor(.pink)
                        .padding(.trailing, 8)

                    Text("ManiiFest")
                        .font(.system(size: 36, weight: .bold, design: .rounded)) // Modern Font
                        .foregroundColor(.black) // Clean Color
                }
                .padding(.top, 32)

                Text(nfcManager.tagMessage)
                    .font(.subheadline) // Smaller font for the message
                    .fontWeight(.medium)
                    .padding()
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray) // Muted color for the message

                Spacer()

                //Data Input View
                DataInputView(nfcManager: nfcManager, urlToWrite: $urlToWrite)
                    .disabled(nfcManager.isScanning || nfcManager.isWriting)

                // Progress View
                if nfcManager.showProgressView {
                    ProgressView()
                        .padding()
                }

                // Write Button
                Button {
                    nfcManager.dataToWrite = [mimeTypeKey: "text/plain", payloadKey: urlToWrite]
                    nfcManager.startNFCWriteSession()
                } label: {
                    HStack {
                        Image(systemName: "link.icloud.fill")
                        Text("Set Content")
                            .font(.headline)
                    }
                }
                .buttonStyle(
                    ModernButtonStyle(
                        gradientColors: [.blue, .purple],  // Use specific colors for main action
                        foregroundColor: .white
                    )
                )
                .padding()
                .disabled(nfcManager.isScanning || nfcManager.isWriting)

                // Scan Button (For Others to Scan)
                Button {
                    nfcManager.startNFCSession()
                } label: {
                    HStack {
                        Image(systemName: "eye")
                        Text("Scan Nail")
                            .font(.headline)
                    }
                }
                .buttonStyle(
                    ModernButtonStyle(
                        gradientColors: [Color(red: 0.2, green: 0.2, blue: 0.0), Color.black],  // Darker Gold / Black Gradient
                        foregroundColor: .white
                    )
                )
                .padding()
                .disabled(nfcManager.isScanning || nfcManager.isWriting)

                //Display URL analytics
                Section(header: Text("URL Analytics").font(.title3).fontWeight(.semibold).padding(.leading)) {
                   if nfcManager.urlTracker.trackedURLs.isEmpty {
                       Text("No URLs tracked yet.")
                           .foregroundColor(.secondary)
                           .padding()
                   } else {
                       ScrollView(.horizontal, showsIndicators: false) {
                           HStack {
                               ForEach(nfcManager.urlTracker.trackedURLs) { trackedURL in
                                   AnalyticsCard(trackedURL: trackedURL) //Use of the other file's code to display analytics.
                                       .padding(.horizontal, 5)
                               }
                           }
                           .padding(.horizontal)
                       }
                   }
               }

                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
            .background(Color.white) // Clean white background
        }
        .alert(isPresented: $nfcManager.presentAlert) {
            Alert(
                title: Text("Error"),
                message: Text(nfcManager.errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct AnalyticsCard: View {
    let trackedURL: TrackedURL

    var body: some View {
        VStack(alignment: .leading) {
            Text(trackedURL.url)
                .font(.headline)
                .lineLimit(1)
                .truncationMode(.middle)
            HStack {
                Image(systemName: "calendar")
                Text("Write: \(trackedURL.writeTimestamp.formatted(date: .abbreviated, time: .omitted))")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            HStack {
                Image(systemName: "number")
                Text("Reads: \(trackedURL.readCount)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            HStack {
                Image(systemName: "clock")
                Text("Last Read: \(trackedURL.lastReadTimestamp?.formatted(date: .abbreviated, time: .omitted) ?? "Never")")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .frame(width: 200)
    }
}
