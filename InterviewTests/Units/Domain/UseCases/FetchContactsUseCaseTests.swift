//
//  FetchContactsUseCaseTests.swift
//  InterviewTests
//
//  Created by Lucas Ferreira Machado on 31/08/21.
//

import Foundation

import XCTest
@testable import Interview

class FetchContactsUseCaseTests: XCTestCase {
    var outputMock: FetchContactsUseCaseOutputMock!
    var repositoryMock: FetchContactsRepositoryMock!
    var systemUnderTest: FetchContactsUseCase!

    override func setUp() {
        outputMock = FetchContactsUseCaseOutputMock()
        repositoryMock = FetchContactsRepositoryMock()
        systemUnderTest = FetchContactsUseCase(repository: self.repositoryMock)
    }

    override func tearDown() {

    }

    private func fetchContacts() {
        systemUnderTest.fetchContacts(output: outputMock)
        XCTAssertTrue(repositoryMock.isFecthContactsCalled, "Method was not called.")
        XCTAssertEqual(repositoryMock.fecthContactsCallCount, 1, "Invalid method callCount times.")
    }
}


// MARK: Unit Tests - Success cases
extension FetchContactsUseCaseTests {
    func test_fetch_contacts_success() {

        let expectation = XCTestExpectation(description: """
    Given: a good internet connection
    When:  its attempt to fetch contacts
    Then:  It should complete without errors or warnings
    """)

        guard let expectedResult = try? mockedContacts() else {
            return XCTFail("Invalid mocked contacts.")
        }

        repositoryMock.result = .success(expectedResult)


        outputMock.onFecthContactsSuccessClosure = { contacts in
            XCTAssertEqual(contacts, expectedResult, "Invalid result.")
            expectation.fulfill()
        }
        outputMock.onFecthContactsFailedClosure = { error in
            XCTFail("Invalid result")
            expectation.fulfill()
        }

        fetchContacts()

        wait(for: [expectation], timeout: 1)
    }
}
