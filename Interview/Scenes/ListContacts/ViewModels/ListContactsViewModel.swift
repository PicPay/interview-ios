import Foundation

protocol ListContactsViewModelDelegate: AnyObject {
    func contactDidLoaded()
    func didReceivedError(_ error: Error)
}

final class ListContactsViewModel {
    private let service: ListContactServiceProtocol
    private let legacyIds = [10, 11, 12, 13]
    
    weak var delegate: ListContactsViewModelDelegate?
    var viewData = ListContactViewData()
    
    init(service: ListContactServiceProtocol = ListContactService()) {
        self.service = service
    }
    
    func isLegacy(id: Int) -> Bool {
        return legacyIds.contains(id)
    }
    
    func loadContacts() {
        service.fetchContacts { [weak self] result in
            switch result {
            case .success(let contacts):
                self?.handleContacts(contacts)
            case .failure(let error):
                self?.delegate?.didReceivedError(error)
            }
        }
    }
    
    private func handleContacts(_ contacts: [Contact]) {
        viewData.contacts = contacts.map {
            ListContactViewData.Contact(
                id: $0.id,
                imageURL: $0.photoURL,
                name: $0.name
            )
        }
        DispatchQueue.main.async {
            self.delegate?.contactDidLoaded()
        }
    }
}
