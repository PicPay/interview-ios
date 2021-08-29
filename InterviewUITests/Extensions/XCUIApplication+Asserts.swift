//
//  XCUIApplication+Asserts.swift
//  InterviewUITests
//
//  Created by Lucas Ferreira Machado on 29/08/21.
//

import XCTest

extension XCUIApplication {
    func shoulDisplayScreenWithTitle(_ title: String) {
        navigationBars.staticTexts[title].shouldDisplay("screen title '\(title)'")
    }
}
