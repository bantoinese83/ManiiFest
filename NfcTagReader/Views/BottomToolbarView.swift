import SwiftUI

struct BottomToolbarView: View {
    // Define gold color
    let goldColor = Color(red: 0.9, green: 0.7, blue: 0.2)
    // Define the Light Pink
    let lightPink = Color(red: 249/255, green: 224/255, blue: 224/255)

    var body: some View {
        HStack {
            // Button 1: Settings
            Button(action: {
                print("Settings Tapped!")
            }) {
                VStack {
                    Image(systemName: "gearshape")
                        .font(.system(size: 20))
                        .foregroundColor(goldColor)
                    Text("Settings")
                        .font(.caption)
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity)
            }

            // Button 2: Home
            Button(action: {
                print("Home Tapped!")
            }) {
                VStack {
                    Image(systemName: "house")
                        .font(.system(size: 20))
                        .foregroundColor(goldColor)
                    Text("Home")
                        .font(.caption)
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity)
            }
            // Button 3: Favorites
            Button(action: {
                print("Favorites Tapped!")
            }) {
                VStack {
                    Image(systemName: "heart")
                        .font(.system(size: 20))
                        .foregroundColor(goldColor)
                    Text("Favorites")
                        .font(.caption)
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity)
            }
            // Button 4: NFC Content
            Button(action: {
                print("NFC Content Tapped!")
            }) {
                VStack {
                    Image(systemName: "tag") // Example NFC icon - adjust as needed
                        .font(.system(size: 20))
                        .foregroundColor(goldColor)
                    Text("NFC Content")
                        .font(.caption)
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 20) // Extra padding for the home indicator on newer iPhones
        .background(lightPink.opacity(0.7)) //Changed
        .overlay(
            Rectangle()
                .frame(height: 1, alignment: .top)
                .foregroundColor(Color.gray.opacity(0.2))
        )
        .frame(maxWidth: .infinity)
    }
}

struct BottomToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomToolbarView()
    }
}
