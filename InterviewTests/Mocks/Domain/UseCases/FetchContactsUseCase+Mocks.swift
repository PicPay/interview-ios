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

    var isOnFetchContactsSuccessCalled = false
    var onFetchContactsSuccessCallCount = 0

    func fetchContacts(output: FetchContactsUseCaseOutput?) {
        isOnFetchContactsSuccessCalled = true
        onFetchContactsSuccessCallCount += 1

        if let contacts = successData {
            output?.onFetchContactsSuccess(contacts: contacts)
        }

        if let error = failureError {
            output?.onFetchContactsFailed(error: error)
        }
    }
}
