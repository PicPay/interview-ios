//
//  FetchContactsUseCaseOutput+Mocks.swift
//  InterviewTests
//
//  Created by Lucas Ferreira Machado on 31/08/21.
//

import XCTest

class FetchContactsUseCaseOutputMock: FetchContactsUseCaseOutput {
    
    var onFetchContactsSuccessClosure: ([Contact]) -> Void = {_ in}
    var onFetchContactsFailedClosure: (Error) -> Void = {_ in}

    var isOnFetchContactsSuccessCalled = false
    var isOnFetchContactsFailedCalled = false

    var onFetchContactsSuccessCallCount = 0
    var onFetchContactsFailedCallCount = 0

    func onFetchContactsSuccess(contacts: [Contact]) {
        isOnFetchContactsSuccessCalled = true
        onFetchContactsSuccessCallCount += 1
        onFetchContactsSuccessClosure(contacts)
       
    }

    func onFetchContactsFailed(error: Error) {
        isOnFetchContactsFailedCalled = true
        onFetchContactsFailedCallCount += 1
        onFetchContactsFailedClosure(error)
    }
}
