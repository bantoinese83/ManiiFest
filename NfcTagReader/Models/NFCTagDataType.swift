import Foundation

enum NFCTagDataType: String, CaseIterable, Identifiable, Codable { // Conform to codable
    case url

    var id: String { self.rawValue }

    var displayValue: String {
        switch self {
        case .url: return "URL"
        }
    }
}
