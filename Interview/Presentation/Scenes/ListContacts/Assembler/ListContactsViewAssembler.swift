//
//  ListContactsViewAssembler.swift
//  Interview
//
//  Created by Lucas Ferreira Machado on 31/08/21.
//

import UIKit

class ListContactsViewAssembler {

    static func assemble() -> UIViewController {
        ListContactsViewController(viewModel: makeListContactsViewModel())
    }

    static func makeListContactsViewModel() -> ListContactsViewModelInput {
        let repository = makeFetchContactsRepository()
        let fetchContactsUseCase = FetchContactsUseCase(repository: repository)
        return ListContactsViewModel(fetchContactsUseCase: fetchContactsUseCase)
    }

    static func makeContactCellViewModel(contact: Contact) -> ContactCellViewModelInput {
        let checkLegacyUsersUseCase = CheckLegacyUsersUseCase()
        return ContactCellViewModel(contact: contact,
                                    checkLegacyUsersUseCase: checkLegacyUsersUseCase)
    }

    static func makeFetchContactsRepository() -> FetchContactsRepositoryType {
        let httpClient = HTTPClient()
        let remoteDataSource = NetworkContactDataSource(httpClient: httpClient)
        return FetchContactsRepository(remoteDataSource: remoteDataSource)
    }
}
