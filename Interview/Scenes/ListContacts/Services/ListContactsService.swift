import Foundation

private let apiURL = "https://run.mocky.io/v3/00b73c4d-1254-44f3-80c8-ca6dc56d0e2b"

class ListContactService {
    func fetchContacts(completion: @escaping ([Contact]?, Error?) -> Void) {
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
                let decoded = try decoder.decode([Contact].self, from: jsonData)
                
                completion(decoded, nil)
            } catch let error {
                completion(nil, error)
            }
        }
        
        task.resume()
    }
}
