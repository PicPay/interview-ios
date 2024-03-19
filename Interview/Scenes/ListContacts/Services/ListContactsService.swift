import Foundation

final class ListContactService: ContactServiceProvider {

    func fetchContacts(completion: @escaping (Result<[Contact], Error>) -> Void) {
        guard let url = URL(string: APIConstants.apiURL) else {
            completion(.failure(NSError(domain: "InvalidURL", code: 0)))
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self else { return }
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard response?.isHTTPStatusCodeValid() ?? false else {
                completion(.failure(NSError(domain: "HTTPError", code: 0)))
                return
            }
            
            guard let jsonData = data else {
                completion(.failure(NSError(domain: "NoData", code: 0)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([Contact].self, from: jsonData)
                
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
