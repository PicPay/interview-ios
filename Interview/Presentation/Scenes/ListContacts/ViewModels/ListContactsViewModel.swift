import Foundation

class ListContactsViewModel {
    let fetchContactsUseCase: FetchContactsUseCase
    
    private var completion: (([Contact]?, Error?) -> Void)?
    
    init(fetchContactsUseCase: FetchContactsUseCase) {
        self.fetchContactsUseCase = fetchContactsUseCase
    }
    
    func loadContacts(_ completion: @escaping ([Contact]?, Error?) -> Void) {
        self.completion = completion
        fetchContactsUseCase.fetchContacts(completion: handleFetchContacts)
    }
    
    private func handleFetchContacts(result: Result<[Contact], Error>) {
        switch result {
        case .success(let contacts):
            completion?(contacts, nil)
        case .failure(let error):
            completion?(nil, error)
        }
    }
}
