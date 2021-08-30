//
//  XCUIApplication+Asserts.swift
//  InterviewUITests
//
//  Created by Lucas Ferreira Machado on 29/08/21.
//

import XCTest

extension XCUIApplication {

    @discardableResult
    func shouldDisplayScreenWithTitle(_ title: String) -> XCUIElement {
        let uiElement = navigationBars.staticTexts[title]
        uiElement.shouldDisplay("screen title '\(title)'")
        return uiElement
    }

    @discardableResult
    func shouldDisplayAlertWithTitle(_ title: String) -> XCUIElement {
        let uiElement = alerts[title]
        uiElement.shouldDisplay("alert with title '\(title)'")
        return uiElement
    }

    @discardableResult
    func clickOnCellWithText(_ text: String) -> XCUIElement {
        let uiElement = tables.cells.staticTexts[text]
        uiElement.shouldDisplay("cell with text '\(text)'")
        uiElement.tap()
        return uiElement
    }
}
