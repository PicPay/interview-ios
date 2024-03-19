//
//  MockContactService.swift
//  InterviewTests
//
//  Created by Jarede Lima on 18/03/24.
//  Copyright © 2024 PicPay. All rights reserved.
//

import XCTest
@testable import Interview

class MockContactService: ContactServiceProvider {
    
    func fetchContacts(completion: @escaping (Result<[Contact], Error>) -> Void) {
        
        let contacts = [Contact(id: 20, name: "John Doe", photoURL: "https://example.com/photo1.jpg"),
                        Contact(id: 2, name: "Jane Smith", photoURL: "https://example.com/photo2.jpg"),
                        Contact(id: 11, name: "Alice Johnson", photoURL: "https://example.com/photo3.jpg")]
        completion(.success(contacts))
    }
    
    func isHTTPStatusCodeValid(_ response: URLResponse?) -> Bool {
        return true
    }
}
