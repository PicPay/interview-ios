//
//  ContactDataSource.swift
//  Interview
//
//  Created by Lucas Ferreira Machado on 30/08/21.
//  Copyright © 2021 PicPay. All rights reserved.
//

import Foundation

protocol ContactDataSourceType {
    func getAll(completion: @escaping (Result<[Contact], Error>) -> Void)
}
