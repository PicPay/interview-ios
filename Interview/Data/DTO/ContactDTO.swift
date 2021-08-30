//
//  ContactDTO.swift
//  Interview
//
//  Created by Lucas Ferreira Machado on 30/08/21.
//

import Foundation

/*
 Json Contract
[
  {
    "id": 1,
    "name": "Shakira",
    "photoURL": "https://api.adorable.io/avatars/285/a1.png"
  }
]
*/

struct ContactDTO: Codable {
    let id: Int
    let name: String
    let photoURL: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case photoURL = "photoURL"
        case id = "id"
    }
}
