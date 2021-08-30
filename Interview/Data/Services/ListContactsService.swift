import Foundation

private let apiURL = "https://run.mocky.io/v3/1d9c3bbe-eb63-4d09-980a-989ad740a9ac"

class ListContactService {
    func fetchContacts(completion: @escaping ([ContactDTO]?, Error?) -> Void) {
        guard let api = URL(string: apiURL) else {
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
