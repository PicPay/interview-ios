import Foundation

private let apiURL = "https://run.mocky.io/v3/4d20a0f9-6a47-4db3-95bc-e60050a91353"

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
