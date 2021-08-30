//
//  FetchContactsRepository.swift
//  Interview
//
//  Created by Lucas Ferreira Machado on 30/08/21.
//

import Foundation

protocol FetchContactsRepositoryType {
    func fetchContacts(completion: @escaping (Result<[Contact], Error>) -> Void)
}

class FetchContactsRepository: FetchContactsRepositoryType {
    var dataSource: ContactDataSourceType!

    init(remoteDataSource: ContactDataSourceType = NetworkContactDataSource()) {
        self.dataSource = remoteDataSource
    }
    
    func fetchContacts(completion: @escaping (Result<[Contact], Error>) -> Void) {
        dataSource.getAll(completion: completion)
    }
}
