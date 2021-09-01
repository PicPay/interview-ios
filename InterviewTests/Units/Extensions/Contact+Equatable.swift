//
//  Contact+Equatable.swift
//  InterviewTests
//
//  Created by Lucas Ferreira Machado on 31/08/21.
//

import Foundation

extension Contact: Equatable {
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        lhs.id == rhs.id
            && lhs.name == rhs.name
            && lhs.photoURL == rhs.photoURL
    }
}
