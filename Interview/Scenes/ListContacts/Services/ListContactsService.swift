import Foundation

private let apiURL = "https://run.mocky.io/v3/d26d86ec-fb82-48a7-9c73-69e2cb728070"

protocol ListContactServiceProtocol {
    @discardableResult
    func fetchContacts(completion: @escaping (Result<[Contact], Error>) -> Void) -> URLSessionDataTask?
}

final class ListContactService: ListContactServiceProtocol {
    @frozen enum BusinessError: LocalizedError {
        case invalidURL
        case emptyReturn
        case httpError(statusCode: Int)
        
        var errorDescription: String? {
            switch self {
            case .emptyReturn: return "Nenhum dado retornado"
            case .invalidURL: return "URL solicitada é inválida"
            case .httpError(let statusCode): return "Error: \(statusCode)"
            }
        }
    }
    
    @discardableResult func fetchContacts(completion: @escaping (Result<[Contact], Error>) -> Void) -> URLSessionDataTask? {
        guard let api = URL(string: apiURL) else {
            completion(.failure(BusinessError.invalidURL))
            return nil
        }
        let task = URLSession.shared.dataTask(with: api) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(BusinessError.emptyReturn))
                return
            }
            switch response.statusCode {
            case 200...299:
                do {
                    guard let data else {
                        completion(.failure(BusinessError.emptyReturn))
                        return
                    }
                    completion(.success(try JSONDecoder().decode([Contact].self, from: data)))
                } catch {
                    completion(.failure(error))
                }
            default:
                completion(.failure(BusinessError.httpError(statusCode: response.statusCode)))
            }
        }
        task.resume()
        return task
    }
}
