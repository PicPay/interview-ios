//
//  ListContactsViewControllerTests.swift
//  InterviewTests
//
//  Created by Jarede Lima on 18/03/24.
//  Copyright © 2024 PicPay. All rights reserved.
//

import XCTest
@testable import Interview

class MockTableViewDelegate: NSObject, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

class ListContactsViewControllerTests: XCTestCase {
    
    var viewController: ListContactsViewController!
    var viewModel: ListContactsViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ListContactsViewModel()
        viewController = ListContactsViewController()
        viewController.viewModel = viewModel
        _ = viewController.view
    }
    
    override func tearDown() {
        viewController = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testViewDidLoad() {
        XCTAssertNotNil(viewController.tableView.dataSource, "Table view data source should not be nil")
        XCTAssertNotNil(viewController.tableView.delegate, "Table view delegate should not be nil")
    }

    func testTableViewDataSource() {
        let tableView = viewController.tableView
        XCTAssertNotNil(tableView.dataSource, "Table view data source should not be nil")
        XCTAssertEqual(tableView.dataSource?.tableView(tableView, numberOfRowsInSection: 0), 0, "Number of rows in table view should be 0 initially")
    }
    
    func testTableViewDelegate() {
        let tableView = viewController.tableView
        XCTAssertNotNil(tableView.delegate, "Table view delegate should not be nil")
        
        let mockTableViewDelegate = MockTableViewDelegate()
        let cell = mockTableViewDelegate.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertNotNil(cell, "Table view cell should not be nil")
    }
}
