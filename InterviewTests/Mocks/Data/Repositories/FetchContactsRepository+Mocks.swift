//
//  FetchContactsRepository+Mocks.swift
//  InterviewTests
//
//  Created by Lucas Ferreira Machado on 01/09/21.
//  Copyright © 2021 PicPay. All rights reserved.
//

import Foundation

class FetchContactsRepositoryMock: FetchContactsRepositoryType {
    var isFecthContactsCalled = false
    var fecthContactsCallCount = 0
    var result: Result<[Contact], Error>? = nil

    func fetchContacts(completion: @escaping (Result<[Contact], Error>) -> Void) {
        isFecthContactsCalled = true
        fecthContactsCallCount += 1
        if let result = result {
            completion(result)
        }
    }
}
