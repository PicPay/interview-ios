//
//  User.swift
//  Interview
//
//  Created by Lucas Ferreira Machado on 31/08/21.
//

import Foundation

class User {
    static let legacyIds = [10, 11, 12, 13]

    static func isLegacy(id: Int) -> Bool {
        return legacyIds.contains(id)
    }
}
