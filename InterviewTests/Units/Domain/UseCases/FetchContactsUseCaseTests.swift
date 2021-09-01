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
        XCTAssertTrue(repositoryMock.isFetchContactsCalled, "Method was not called.")
        XCTAssertEqual(repositoryMock.fetchContactsCallCount, 1, "Invalid method callCount times.")
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


        outputMock.onFetchContactsSuccessClosure = { contacts in
            XCTAssertEqual(contacts, expectedResult, "Invalid result.")
            expectation.fulfill()
        }
        outputMock.onFetchContactsFailedClosure = { error in
            XCTFail("Invalid result")
            expectation.fulfill()
        }

        fetchContacts()

        wait(for: [expectation], timeout: 1)
    }
}

// MARK: Unit Tests - Failure cases
extension FetchContactsUseCaseTests {
    func test_fetch_contacts_notConnectedToInternet() {

        let expectation = XCTestExpectation(description: """
    Given: No internet connection
    When:  its attempt to fetch contacts
    Then:  It should return a notConnectedToInternet error
    """)


        let expectedError = URLError(.notConnectedToInternet)
        repositoryMock.result = .failure(expectedError)


        outputMock.onFetchContactsSuccessClosure = { contacts in
            XCTFail("Invalid result")
            expectation.fulfill()
        }
        outputMock.onFetchContactsFailedClosure = { error in
            XCTAssertEqual(error as! URLError, expectedError, "Invalid error code.")
            expectation.fulfill()
        }


        fetchContacts()

        wait(for: [expectation], timeout: 1)
    }
}
