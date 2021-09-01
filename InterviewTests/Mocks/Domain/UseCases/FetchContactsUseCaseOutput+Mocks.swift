//
//  FetchContactsUseCaseOutput+Mocks.swift
//  InterviewTests
//
//  Created by Lucas Ferreira Machado on 31/08/21.
//

import XCTest

class FetchContactsUseCaseOutputMock: FetchContactsUseCaseOutput {
    
    var onFecthContactsSuccessClosure: ([Contact]) -> Void = {_ in}
    var onFecthContactsFailedClosure: (Error) -> Void = {_ in}

    var isOnFecthContactsSuccessCalled = false
    var isOnFecthContactsFailedCalled = false

    var onFecthContactsSuccessCallCount = 0
    var onFecthContactsFailedCallCount = 0

    func onFecthContactsSuccess(contacts: [Contact]) {
        isOnFecthContactsSuccessCalled = true
        onFecthContactsSuccessCallCount += 1
        onFecthContactsSuccessClosure(contacts)
       
    }

    func onFecthContactsFailed(error: Error) {
        isOnFecthContactsFailedCalled = true
        onFecthContactsFailedCallCount += 1
        onFecthContactsFailedClosure(error)
    }
}
