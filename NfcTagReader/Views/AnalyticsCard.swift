
import SwiftUI

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
            .background(Color.white.opacity(0.1))
            .cornerRadius(10)
            .frame(width: 200)
        }
    }
