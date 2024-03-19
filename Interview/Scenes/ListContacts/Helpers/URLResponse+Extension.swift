//
//  URLResponse+Extension.swift
//  Interview
//
//  Created by Jarede Lima on 19/03/24.
//  Copyright © 2024 PicPay. All rights reserved.
//

import Foundation

extension URLResponse {
    func isHTTPStatusCodeValid() -> Bool {
        guard let httpResponse = self as? HTTPURLResponse else {
            return false
        }
        return (200...299).contains(httpResponse.statusCode)
    }
}
