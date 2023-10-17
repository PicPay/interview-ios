//
//  ListContactViewData.swift
//  Interview
//
//  Created by Bruno Alves on 17/10/23.
//  Copyright © 2023 PicPay. All rights reserved.
//

import Foundation

struct ListContactViewData {
    struct Contact {
        let id: Int
        let imageURL: String
        let name: String
    }
    
    var contacts = [Contact]()
}
