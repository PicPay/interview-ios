//
//  FetchContactsUseCase.swift
//  Interview
//
//  Created by Lucas Ferreira Machado on 30/08/21.
//

import Foundation

protocol FetchContactsUseCase {
    func fetchContacts(completion: @escaping (Result<[Contact], Error>) -> Void)
}
