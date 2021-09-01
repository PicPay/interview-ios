//
//  ContactTests.swift
//  InterviewTests
//
//
//  Created by Lucas Ferreira Machado on 31/08/21.
//

import Foundation

import XCTest
@testable import Interview

class ContactTests: XCTestCase {
}

// MARK: Unit Tests - Success Cases
extension ContactTests {

    func test_decode_valid_contact_json_data() {

        let expectedContact = try? mockedContacts(data: validContactData).first

        let contact = Contact()
        contact.id = 2
        contact.name = "Beyonce"
        contact.photoURL = "https://picsum.photos/100/100"

        XCTAssertTrue(contact == expectedContact, "Is not the same.")
    }
}

// MARK: Unit Tests - Failure Cases
extension ContactTests {
    func test_decode_invalid_contact_json_data() {
        XCTAssertThrowsError(try mockedContacts(data: invalidContactData), "Should fail when use invalid data.")
    }
}
