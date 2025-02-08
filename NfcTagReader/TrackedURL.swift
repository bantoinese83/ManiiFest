import Foundation

struct TrackedURL: Identifiable, Codable {
    let id = UUID()
    let url: String
    let writeTimestamp: Date
    var readCount: Int = 0
    var lastReadTimestamp: Date?

    enum CodingKeys: String, CodingKey {
        case id, url, writeTimestamp, readCount, lastReadTimestamp
    }
}
