//
//  ContactServiceProvider.swift
//  Interview
//
//  Created by Jarede Lima on 19/03/24.
//  Copyright © 2024 PicPay. All rights reserved.
//

import Foundation

protocol ContactServiceProvider {
    func fetchContacts(completion: @escaping (Result<[Contact], Error>) -> Void)
}
