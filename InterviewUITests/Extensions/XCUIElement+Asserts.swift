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

    @discardableResult
    func withText(_ text: String) -> XCUIElement {
        let uiElement = staticTexts[text]
        uiElement.shouldDisplay("text '\(text)'")
        return self
    }

    @discardableResult
    func withButton(title: String) -> XCUIElement {
        let uiElement = buttons[title]
        uiElement.shouldDisplay("button with title '\(title)'")
        return self
    }
}
