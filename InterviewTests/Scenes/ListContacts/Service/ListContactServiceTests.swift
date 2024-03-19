import XCTest
@testable import Interview

class ListContactServiceTests: XCTestCase {
    
    var contactService: ContactServiceProvider!
    
    override func setUp() {
        super.setUp()
        contactService = ListContactService()
    }
    
    override func tearDown() {
        contactService = nil
        super.tearDown()
    }
    
    func testFetchContacts() throws {
        let expectation = expectation(description: "Fetch contacts expectation")
        
        contactService.fetchContacts { result in
            switch result {
            case .success(let contacts):
                XCTAssertFalse(contacts.isEmpty, "Contacts should not be empty")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to fetch contacts with error: \(error.localizedDescription)")
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
}

var mockData: Data? {
    """
    [{
      "id": 2,
      "name": "Beyonce",
      "photoURL": "https://api.adorable.io/avatars/285/a2.png"
    }]
    """.data(using: .utf8)
}
