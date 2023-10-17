import Foundation

protocol ListContactsViewModelDelegate: AnyObject {
    func contactDidLoaded()
    func didReceivedError(_ error: Error)
}

final class ListContactsViewModel {
    private let service: ListContactServiceProtocol
    private let legacyIds = [10, 11, 12, 13]
    private var dataTask: URLSessionDataTask?
    
    weak var delegate: ListContactsViewModelDelegate?
    var viewData = ListContactViewData()
    
    init(service: ListContactServiceProtocol = ListContactService()) {
        self.service = service
    }
    
    func isLegacy(id: Int) -> Bool {
        return legacyIds.contains(id)
    }
    
    func loadContacts() {
        dataTask = service.fetchContacts { [weak self] result in
            switch result {
            case .success(let data):
                self?.handleContacts(data)
            case .failure(let error):
                self?.delegate?.didReceivedError(error)
            }
        }
    }
    
    func cancelAsyncTasks() {
        dataTask?.cancel()
    }
    
    // MARK: - Private methods
    
    private func handleContacts(_ data: Data) {
        do {
            let contacts = try JSONDecoder().decode([Contact].self, from: data)
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
        } catch {
            delegate?.didReceivedError(error)
        }
    }
}
