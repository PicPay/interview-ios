//
//  XCUIElement+Asserts.swift
//  InterviewUITests
//
//  Created by Lucas Ferreira Machado on 29/08/21.
//

import XCTest

extension XCUIElement {
    func shouldDisplay(_ description: String) {
        XCTAssertTrue(waitForExistence(timeout: 5), "It should be display \(description)")
    }
}
