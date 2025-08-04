//
//  URLSessionProtocol.swift
//  Interview
//
//  Created by Vitor Augusto Silva on 02/08/25.
//  Copyright © 2025 PicPay. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request:URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
