//
//  URLRequest+APIs.swift
//  Interview
//
//  Created by Lucas Ferreira Machado on 30/08/21.
//

import Foundation

extension URLRequest {

    static func fetchContacts() -> URLRequest {
        let url = URL(string: AppConfiguration.shared.ApiUrl)
        return URLRequest(url: url!)
    }
    
}
