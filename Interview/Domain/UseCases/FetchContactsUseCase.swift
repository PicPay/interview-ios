//
//  FetchContactsUseCase.swift
//  Interview
//
//  Created by Lucas Ferreira Machado on 30/08/21.
//

import Foundation

protocol FetchContactsUseCaseInput {
    func fetchContacts(output: FetchContactsUseCaseOutput?)
}

protocol FetchContactsUseCaseOutput {
    func onFetchContactsSuccess(contacts:[Contact])
    func onFetchContactsFailed(error: Error)
}

class FetchContactsUseCase: FetchContactsUseCaseInput {

    var repository: FetchContactsRepositoryType
    init(repository: FetchContactsRepositoryType) {
        self.repository = repository
    }

    func fetchContacts(output: FetchContactsUseCaseOutput?) {
        repository.fetchContacts { result in
            switch result {
            case .success(let contacts):
                output?.onFetchContactsSuccess(contacts: contacts)
            case .failure(let error):
                output?.onFetchContactsFailed(error: error)
            }
        }
    }
}
