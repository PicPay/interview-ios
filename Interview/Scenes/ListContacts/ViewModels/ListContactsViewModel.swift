import Foundation

enum ViewState {
    case loading
    case ready
    case error(ContactErrors)
}

struct UserIdsLegacy {
    private static let legacyIds: [Int] = [10, 11, 12, 13]
    
    static func isLegacy(id: Int) -> Bool {
        return legacyIds.contains(id)
    }
}

class ListContactsViewModel {
    var onViewStateChange: ((ViewState) -> Void)?
        private(set) var contactList: [Contact] = []
        private var viewState: ViewState = .ready {
        didSet {
            onViewStateChange?(viewState)
        }
    }
    
    func loadContacts() async {
        viewState = .loading
        do {
            self.contactList = try await ListContactService.shared.fetchContacts()
            self.viewState = .ready
        }catch {
            if let contactError = error as? ContactErrors {
                viewState = .error(contactError)
            } else {
                viewState = .error(.unknow)
            }
        }
    }
}
