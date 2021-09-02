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

    //    Given that application is launched
    //    When the contact list screen appears
    //    Then It should display the screen title
    func test_showScreenTitle() throws {
        app.shouldDisplayScreenWithTitle("Lista de contatos") 
    }


    //    Given that application is launched and the Contact List screen is displayed
    //    When User clicks on the first contact's name in the list
    //    Then It should display an dialog with the selected contact's name
    func test_selectFirstContactFromList() throws {
        let contactName = "Shakira"
        app.clickOnCellWithText(contactName)
        app.shouldDisplayAlertWithTitle("Você tocou em")
            .withText(contactName)
            .withButton(title: "OK")
    }

    //    Given that application is launched and the Contact List screen is displayed
    //    When User clicks on a legacy contact in the list
    //    Then It should display an dialog with text "Você tocou no contato sorteado"
    func test_selectLegacyContactFromList() throws {
        let contactName = "Judar Lima"
        app.clickOnCellWithText(contactName)
        app.shouldDisplayAlertWithTitle("Atenção")
            .withText("Você tocou no contato sorteado")
            .withButton(title: "OK")
    }

    //    Given that application is launched and the Contact List screen is displayed
    //    When User scroll up the contact list
    //    Then It should take no more than 100 milli seconds
    func test_scrollContactList() throws {
        let firstCell = app.shouldDisplayCellWithText("Shakira")

        let timePerformanceMetric = TimePerformanceMetric()
        measure(metrics: [timePerformanceMetric]) {
            if firstCell.isHittable {
                firstCell.swipeUp(velocity: .fast)
            }
        }
        let average = timePerformanceMetric.average(unit: .milli).integerValue()
        let expected = TimeMetric.init(value: 100, unit: .milli).integerValue()
        XCTAssert(average < expected, "scrolling up the contact list should take no more than 100 ms. Current is: \(average) ms")
    }
}
