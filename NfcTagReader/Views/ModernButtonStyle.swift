
import SwiftUI

struct ModernButtonStyle: ButtonStyle {
    let gradientColors: [Color]
    let foregroundColor: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 18, weight: .bold, design: .rounded))
            .foregroundColor(foregroundColor)
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: gradientColors.last ?? .clear.opacity(0.4), radius: 10, x: 0, y: 5) // Neon glow effect
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1) // Subtle border
            )
            .opacity(configuration.isPressed ? 0.85 : 1.0) // Dim when pressed
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // Press animation
            .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0), value: configuration.isPressed)
    }
}
