import Foundation

class ListContactService {
    func fetchContacts(completion: @escaping ([ContactDTO]?, Error?) -> Void) {
        guard let api = URL(string: AppConfiguration.shared.apiKey) else {
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: api) { (data, response, error) in
            guard let jsonData = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([ContactDTO].self, from: jsonData)
                
                completion(decoded, nil)
            } catch let error {
                completion(nil, error)
            }
        }
        
        task.resume()
    }
}
