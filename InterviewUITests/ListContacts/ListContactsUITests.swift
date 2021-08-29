//
//  ListContactsUITests.swift
//  InterviewUITests
//
//  Created by Lucas Ferreira Machado on 29/08/21.
//

import XCTest

class ListContactsUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    //    Given that I launch the application
    //    When I go to ListContacts screen
    //    Then It should display the screen title
    func test_showScreenTitle() throws {
        app.shoulDisplayScreenWithTitle("Lista de contatos") 
    }
}
