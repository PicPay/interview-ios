//
//  Errors.swift
//  Interview
//
//  Created by Vitor Augusto Silva on 02/08/25.
//  Copyright © 2025 PicPay. All rights reserved.
//

import Foundation

enum ContactErrors: Error {
    case invalidURL
    case invalidRequest
    case decodingFailed
    case unknow
}

extension ContactErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL inválida. Por favor informe a URL corretamente"
        case .invalidRequest:
            return "Não foi possivel realizar essa requisição"
        case .decodingFailed:
            return "Não foi possivel recuperar os dados"
        case .unknow:
            return "Erro desconhecido"
        }
    }
}
