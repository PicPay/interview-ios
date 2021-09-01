//
//  FetchContactsUseCase+Mocks.swift
//  InterviewTests
//
//  Created by Lucas Ferreira Machado on 31/08/21.
//

import XCTest

class FetchContactsUseCaseMock: FetchContactsUseCaseInput {

    var successData: [Contact]? = nil
    var failureError: Error? = nil

    var isOnFecthContactsSuccessCalled = false
    var onFecthContactsSuccessCallCount = 0

    func fetchContacts(output: FetchContactsUseCaseOutput?) {
        isOnFecthContactsSuccessCalled = true
        onFecthContactsSuccessCallCount += 1

        if let contacts = successData {
            output?.onFecthContactsSuccess(contacts: contacts)
        }

        if let error = failureError {
            output?.onFecthContactsFailed(error: error)
        }
    }
}
