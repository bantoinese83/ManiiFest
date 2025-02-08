import SwiftUI

struct ContentView: View {
    @ObservedObject var nfcManager = NFCManager()
    @State private var urlToWrite: String = ""
    
    // Define the light pink color
    let lightPink = Color(red: 249/255, green: 224/255, blue: 224/255)
    
    var body: some View {
        NavigationView {
            ZStack {
                lightPink.ignoresSafeArea() // Set the background color here
                
                VStack {
                    HStack {
                        
                        ZStack {
                            Text("ManiiFest") // White Outline
                                .font(.system(size: 36, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.3), radius: 1, x: 1, y: 1) // Outline Shadow
                                .offset(x: 1, y: 1)
                            
                            Text("ManiiFest") //Base Text
                                .font(.system(size: 36, weight: .bold, design: .rounded))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [Color(red: 0.9, green: 0.7, blue: 0.2), Color(red: 0.7, green: 0.5, blue: 0.0)],  // Gold Gradient
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                            
                        }
                        
                    }
                    .padding(.top, 32)
                    
                    // Instructions Section
                    VStack(alignment: .leading) {
                        Text("How to Use ManiiFest:")
                            .font(.headline)
                            .padding(.bottom, 4)
                        
                        Text("1. Enter a URL in the text field.")
                            .font(.subheadline)
                        Text("2. Tap 'Set Content' to write to a tag.")
                            .font(.subheadline)
                        Text("3. Tap 'Scan Nail' to read a tag's URL.")
                            .font(.subheadline)
                    }
                    .padding()
                    .background(Color.white.opacity(0.3))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    
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
                        Spacer()
                        
                    }
                    BottomToolbarView() // Place the toolbar at the bottom
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
    }
}

