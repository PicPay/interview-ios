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
    //    When I go to contact list screen
    //    Then It should display the screen title
    func test_showScreenTitle() throws {
        app.shouldDisplayScreenWithTitle("Lista de contatos") 
    }


    //    Given I open the contact list screen
    //    When I click on the first contact's name in the list
    //    Then It should display an alert with the contact's name
    func test_selectFirstContactFromList() throws {
        let contactName = "Shakira"
        app.clickOnCellWithText(contactName)
        app.shouldDisplayAlertWithTitle("Você tocou em")
            .withText(contactName)
            .withButton(title: "OK")
    }

    //    Given I open the contact list screen
    //    When I click on a legacy contact in the list
    //    Then It should display an alert with text "Você tocou no contato sorteado"
    func test_selectLegacyContactFromList() throws {
        let contactName = "Judar Lima"
        app.clickOnCellWithText(contactName)
        app.shouldDisplayAlertWithTitle("Atenção")
            .withText("Você tocou no contato sorteado")
            .withButton(title: "OK")
    }

    //    Given I open the contact list screen
    //    When I scroll up the contact list
    //    Then It should take no more than 300 milli seconds
    func test_scrollContactList() throws {
        let firstCell = app.shouldDisplayCellWithText("Shakira")

        let timePerformanceMetric = TimePerformanceMetric()
        measure(metrics: [timePerformanceMetric]) {
            if firstCell.isHittable {
                firstCell.swipeUp(velocity: .fast)
            }
        }
        let average = timePerformanceMetric.average(unit: .milli).integerValue()
        let expected = TimeMetric.init(value: 300, unit: .milli).integerValue()
        XCTAssert(average < expected, "scrolling up the contact list should take no more than 300 ms. Current is: \(average) ms")
    }
}
