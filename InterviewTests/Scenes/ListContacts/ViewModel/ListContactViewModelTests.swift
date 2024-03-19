import XCTest
@testable import Interview

class ListContactViewModelTests: XCTestCase {
    
    var viewModel: ListContactsViewModel!
    var mockService: MockContactService!
    
    override func setUp() {
        super.setUp()
        mockService = MockContactService()
        viewModel = ListContactsViewModel(contactService: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testLoadContacts() throws {
        let expectation = expectation(description: "Load contacts expectation")
        
        let expectedFirstContact = Contact(id: 20, name: "John Doe", photoURL: "https://example.com/photo1.jpg")
        
        viewModel.loadContacts { result in
            switch result {
            case .success(let contacts):
                XCTAssertEqual(contacts.count, 3, "Unexpected number of contacts")
                
                if !contacts.isEmpty {
                    XCTAssertEqual(contacts[0].id, expectedFirstContact.id, "First contact id should match")
                    XCTAssertEqual(contacts[0].name, expectedFirstContact.name, "First contact name should match")
                    XCTAssertEqual(contacts[0].photoURL, expectedFirstContact.photoURL, "First contact photoURL should match")
                }
                
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to load contacts with error: \(error.localizedDescription)")
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testIsLegacy() {
        XCTAssertTrue(ListContactsViewModel.isLegacy(contactId: 10), "Contact ID 10 should be legacy")
        XCTAssertFalse(ListContactsViewModel.isLegacy(contactId: 20), "Contact ID 20 should not be legacy")
    }
}
