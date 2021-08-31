//
//  CheckLegacyUsersUseCase.swift
//  Interview
//
//  Created by Lucas Ferreira Machado on 31/08/21.
//

import Foundation

protocol CheckLegacyUsersUseCaseType {
    func isLegacy(userId: Int) -> Bool
}

class CheckLegacyUsersUseCase: CheckLegacyUsersUseCaseType {
    func isLegacy(userId: Int) -> Bool {
        User.isLegacy(id: userId)
    }
}
