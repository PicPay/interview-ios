//
//  HttpClient.swift
//  Interview
//
//  Created by Lucas Ferreira Machado on 30/08/21.
//

import Foundation

protocol HTTPClientType {
    func execute(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void)
}

class HTTPClient: HTTPClientType {
    let session: URLSession!

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func execute(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(error!))
                }
            }
        }.resume()
    }
}
