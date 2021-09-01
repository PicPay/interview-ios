//
//  ImageURLProtocol+IntegrationTests.swift
//  InterviewTests
//
//  Created by Lucas Ferreira Machado on 31/08/21.
//

import UIKit
import XCTest
@testable import Interview

class ImageURLProtocolIntegrationTests: XCTestCase {

    var systemUnderTest: URLSession!

    override func setUp() {
        systemUnderTest = ImageURLProtocol.urlSession
    }

    override func tearDown() {
    }
}

// MARK: Expected Success Tests
extension ImageURLProtocolIntegrationTests {

    func test_load_images_from_network() {
        let expectation = XCTestExpectation(description: """
    Given: A ImageURLProtocol instance and a good internet connection
    When:  its attempt to load an image from the url https://picsum.photos/100/100
    Then:  It should fetch the image data without errors or warnings
    """)

        let imageUrl = URL(string: "https://picsum.photos/100/100")!
        systemUnderTest.dataTask(with: imageUrl  as URL) { (data, response, error) in

            XCTAssertNil(error, "An unexpected error occurred when trying to load images from network.")
            XCTAssertNotNil(data, "No image data was downloaded from network.")
            if let imageData = data {
                XCTAssertNotNil(UIImage(data: imageData), "Invalid image data. it was not possible to create an UIImage from the image data received from network.")
            }
            expectation.fulfill()
        }.resume()

        wait(for: [expectation], timeout: 3)
    }

}

