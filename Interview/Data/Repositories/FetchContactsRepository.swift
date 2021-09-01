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
    var remotedataSource: ContactDataSourceType!

    init(remoteDataSource: ContactDataSourceType) {
        self.remotedataSource = remoteDataSource
    }
    
    func fetchContacts(completion: @escaping (Result<[Contact], Error>) -> Void) {
        remotedataSource.getAll(completion: completion)
    }
}
