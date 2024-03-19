import Foundation

final class ListContactsViewModel {
    private let contactService: ContactServiceProvider
    
    init(contactService: ContactServiceProvider = ListContactService()) {
        self.contactService = contactService
    }
    
    func loadContacts(completion: @escaping (Result<[Contact], Error>) -> Void) {
        contactService.fetchContacts { result in
            switch result {
            case .success(let contacts):
                completion(.success(contacts))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func isLegacy(contactId: Int) -> Bool {
        return UserIdsLegacy.isLegacy(id: contactId)
    }
}
