//
//  AppConfiguration.swift
//  Interview
//
//  Created by Lucas Ferreira Machado on 30/08/21.
//

import Foundation

final class AppConfiguration {

    static let shared = AppConfiguration()

    lazy var ApiUrl: String = {
        guard let apiUrl = Bundle.main.object(forInfoDictionaryKey: "ApiUrl") as? String else {
            fatalError("ApiUrl must not be empty in plist")
        }
        return apiUrl
    }()
}
