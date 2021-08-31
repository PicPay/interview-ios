import Foundation

class ListContactsViewModel {
    let fetchContactsUseCase: FetchContactsUseCaseInput
    let checkLegacyUsersUseCase: CheckLegacyUsersUseCaseType
    
    private var completion: (([Contact]?, Error?) -> Void)?
    
    init(fetchContactsUseCase: FetchContactsUseCaseInput = FetchContactsUseCase(),
         checkLegacyUsersUseCase: CheckLegacyUsersUseCaseType = CheckLegacyUsersUseCase()) {
        self.fetchContactsUseCase = fetchContactsUseCase
        self.checkLegacyUsersUseCase = checkLegacyUsersUseCase
    }
    
    func loadContacts(_ completion: @escaping ([Contact]?, Error?) -> Void) {
        self.completion = completion
        fetchContactsUseCase.fetchContacts(output: self)
    }

    func isLegacy(id: Int) -> Bool {
        checkLegacyUsersUseCase.isLegacy(userId: id)
    }
}

extension ListContactsViewModel: FetchContactsUseCaseOutput {

    func onFecthContactsSuccess(contacts: [Contact]) {
        completion?(contacts, nil)
    }

    func onFecthContactsFailed(error: Error) {
        completion?(nil, error)
    }
}
