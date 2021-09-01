//
//  ListContactsViewModelTests.swift
//  InterviewTests
//
//  Created by Lucas Ferreira Machado on 31/08/21.
//

import Foundation

import XCTest
@testable import Interview

class ListContactsViewModelTests: XCTestCase {
    var useCaseMock: FetchContactsUseCaseMock!
    var systemUnderTest: ListContactsViewModel!

    override func setUp() {
        useCaseMock = FetchContactsUseCaseMock()
        systemUnderTest = ListContactsViewModel(fetchContactsUseCase: useCaseMock)
    }

    override func tearDown() {

    }

    private func fetchContacts() {
        systemUnderTest.fetchContacts()
        XCTAssertTrue(useCaseMock.isOnFetchContactsSuccessCalled, "Method was not called.")
        XCTAssertEqual(useCaseMock.onFetchContactsSuccessCallCount, 1, "Invalid method callCount times.")
    }
}


// MARK: Unit Tests - Success cases
extension ListContactsViewModelTests {
}

// MARK: Unit Tests - Failure cases
extension ListContactsViewModelTests {
    func test_fetch_contacts_notConnectedToInternet() {

        let expectation = XCTestExpectation(description: """
    Given: No internet connection
    When:  its attempt to fetch contacts
    Then:  It should return a notConnectedToInternet error
    """)

        let expectedError = URLError(.notConnectedToInternet)
        useCaseMock.failureError = expectedError

        fetchContacts()

        expectation.fulfill()
        wait(for: [expectation], timeout: 1)
    }
}
