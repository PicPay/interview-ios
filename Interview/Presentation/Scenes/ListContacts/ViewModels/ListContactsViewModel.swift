import Foundation

class ListContactsViewModel {
    let fetchContactsUseCase: FetchContactsUseCaseInput
    
    private var completion: (([Contact]?, Error?) -> Void)?
    
    init(fetchContactsUseCase: FetchContactsUseCaseInput = FetchContactsUseCase()) {
        self.fetchContactsUseCase = fetchContactsUseCase
    }
    
    func loadContacts(_ completion: @escaping ([Contact]?, Error?) -> Void) {
        self.completion = completion
        fetchContactsUseCase.fetchContacts(output: self)
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
