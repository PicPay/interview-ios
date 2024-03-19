//
//  ContactCellTests.swift
//  InterviewTests
//
//  Created by Jarede Lima on 18/03/24.
//  Copyright © 2024 PicPay. All rights reserved.
//

import XCTest
@testable import Interview

class ContactCellTests: XCTestCase {
    
    var cell: ContactCell!
    
    override func setUp() {
        super.setUp()
        cell = ContactCell()
    }
    
    override func tearDown() {
        cell = nil
        super.tearDown()
    }
    
    func testConfigure() {
        let contact = Contact(id: 1, name: "John Doe", photoURL: "https://example.com/photo.jpg")
        cell.configure(with: contact)
        
        XCTAssertEqual(cell.fullnameLabel.text, "John Doe", "Fullname label should be set correctly")
        XCTAssertNil(cell.contactImage.image, "Contact image should not be nil")
    }
}
