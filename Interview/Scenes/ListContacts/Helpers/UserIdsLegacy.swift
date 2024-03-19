//
//  UserIdsLegacy.swift
//  Interview
//
//  Created by Jarede Lima on 18/03/24.
//  Copyright © 2024 PicPay. All rights reserved.
//

import Foundation

struct UserIdsLegacy {
    static let legacyIds = [10, 11, 12, 13]
    
    static func isLegacy(id: Int) -> Bool {
        return legacyIds.contains(id)
    }
}
