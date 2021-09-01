//
//  FetchContactsUseCaseIntegrationTests.swift
//  InterviewTests
//
//  Created by Lucas Ferreira Machado on 31/08/21.
//

import Foundation

import Foundation
import XCTest
@testable import Interview

class FetchContactsUseCaseIntegrationTests: XCTestCase {

    var systemUnderTest: FetchContactsUseCaseInput!

    override func setUp() {
        let repository = ListContactsViewAssembler.makeFetchContactsRepository()
        systemUnderTest = FetchContactsUseCase(repository: repository)
    }

    override func tearDown() {
    }
}

// MARK: Integration Tests
extension FetchContactsUseCaseIntegrationTests {
    func test_async_fetch_contacts() {
        let expectation = XCTestExpectation(description: """
    Given: A FetchContactsUseCase instance and a good internet connection
    When:  its attempt to fetch contacts
    Then:  It should complete without errors or warnings
    """)
        let outputMock = FetchContactsUseCaseOutputMock()
        outputMock.onFetchContactsSuccessClosure = { contacts in
            XCTAssert(contacts.count > 0, "No contacts was Fetched.")
            expectation.fulfill()
        }
        outputMock.onFetchContactsFailedClosure = { error in
            XCTAssertNil(error, "An unexpected error occurred when trying to Fetch contacts.")
            expectation.fulfill()
        }
        systemUnderTest.fetchContacts(output: outputMock)
        wait(for: [expectation], timeout: 3)
    }
}
