//
//  Contact+Mocks.swift
//  InterviewTests
//
//  Created by Lucas Ferreira Machado on 31/08/21.
//

import Foundation

var validContactData: Data {
    """
    [{
      "id": 2,
      "name": "Beyonce",
      "photoURL": "https://picsum.photos/100/100"
    }]
    """.data(using: .utf8)!
}

var invalidContactData: Data {
    """
    [{
      "id": "1",
      "name": "Beyonce",
      "photo_URL": "https://picsum.photos/100/100"
    }]
    """.data(using: .utf8)!
}

func mockedContactDTO(data: Data = validContactData) throws -> [ContactResponseDTO] {
    try Contact.mapToDTO(data: data)
}

func mockedContacts(data: Data = validContactData) throws -> [Contact] {
    try mockedContactDTO(data: data).map { Contact.mapToDomain(responseDTO: $0) }
}
