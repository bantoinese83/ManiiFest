import Foundation

class URLTracker: ObservableObject {
     @Published var trackedURLs: [TrackedURL] = [] {
        didSet {
           saveTrackedURLs()
        }
     }

   let trackedURLsKey = "TrackedURLsKey"

   init() {
       loadTrackedURLs()
   }
    func addURL(url: String) {
       let newTrackedURL = TrackedURL(url: url, writeTimestamp: Date())
       trackedURLs.append(newTrackedURL)
    }

    func recordRead(url: String) {
          if let index = trackedURLs.firstIndex(where: { $0.url == url }) {
              trackedURLs[index].readCount += 1
              trackedURLs[index].lastReadTimestamp = Date()
          }
          else{
              let newTrackedURL = TrackedURL(url: url, writeTimestamp: Date(), readCount: 1, lastReadTimestamp: Date())
              trackedURLs.append(newTrackedURL)
          }
    }
    func saveTrackedURLs() {
          let encoder = JSONEncoder()
          if let encoded = try? encoder.encode(trackedURLs) {
             UserDefaults.standard.set(encoded, forKey: trackedURLsKey)
          }
    }
    func loadTrackedURLs() {
          if let savedURLs = UserDefaults.standard.data(forKey: trackedURLsKey) {
              let decoder = JSONDecoder()
              if let loadedURLs = try? decoder.decode([TrackedURL].self, from: savedURLs) {
                 trackedURLs = loadedURLs
              }
          }
    }
}
