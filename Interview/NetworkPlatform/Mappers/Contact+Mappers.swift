//
//  ContactMapper.swift
//  Interview
//
//  Created by Lucas Ferreira Machado on 30/08/21.
//  Copyright © 2021 PicPay. All rights reserved.
//

import Foundation

extension Contact {

    static func mapToResult(data: Data) -> Result<[Contact], Error> {
        do {
            let dto = try mapToDTO(data: data)
            let domain = mapToDomain(responsesDTO: dto)
            return .success(domain)
        } catch let mapError {
            return .failure(mapError)
        }
    }

    private static func mapToDomain(responsesDTO: [ContactResponseDTO]) -> [Contact] {
        return responsesDTO.map(Self.mapToDomain)
    }

    static func mapToDomain(responseDTO: ContactResponseDTO) -> Contact {

        let contact = Contact()

        contact.id = responseDTO.id
        contact.name = responseDTO.name
        contact.photoURL = responseDTO.photoURL
        contact.photoURL.append("?k=\(contact.id)")

        return contact
    }

    static func mapToDTO(data: Data) throws -> [ContactResponseDTO] {
        try JSONDecoder().decode([ContactResponseDTO].self, from: data)
    }
}
