import Foundation

protocol NFCManagerDelegate: AnyObject {
    func nfcManager(_ manager: NFCManager, didUpdateMessage message: String)
}
