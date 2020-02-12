import Foundation

/******************* SERVICE ********************/
class ListContactService {
    func fetchContacts(completion: @escaping ([Contact]?, Error?) -> Void) {
        /// Usa URLSession para acessar a API e retorna
        DispatchQueue.global().async {
            do {
                guard let jsonData = "[{\"id\":1,\"name\":\"Shakira\",\"photoURL\":\"https://api.adorable.io/avatars/285/a1.png\"},{\"id\":2,\"name\":\"Beyonce\",\"photoURL\":\"https://api.adorable.io/avatars/285/a2.png\"},{\"id\":3,\"name\":\"Tom Cruise\",\"photoURL\":\"https://api.adorable.io/avatars/285/a3.png\"},{\"id\":4,\"name\":\"Tiririca\",\"photoURL\":\"https://api.adorable.io/avatars/285/a4.png\"},{\"id\":5,\"name\":\"Steve Rogers\",\"photoURL\":\"https://api.adorable.io/avatars/285/a5.png\"},{\"id\":6,\"name\":\"Steve Jobs\",\"photoURL\":\"https://api.adorable.io/avatars/285/a6.png\"},{\"id\":7,\"name\":\"Scott Forstall\",\"photoURL\":\"https://api.adorable.io/avatars/285/a7.png\"},{\"id\":8,\"name\":\"Craig Federighi\",\"photoURL\":\"https://api.adorable.io/avatars/285/a8.png\"},{\"id\":9,\"name\":\"Steve Ballmer\",\"photoURL\":\"https://api.adorable.io/avatars/285/a9.png\"},{\"id\":10,\"name\":\"Lucas Romano\",\"photoURL\":\"https://api.adorable.io/avatars/285/a10.png\"},{\"id\":11,\"name\":\"Lucas Cypriano\",\"photoURL\":\"https://api.adorable.io/avatars/285/a11.png\"},{\"id\":12,\"name\":\"Fernando Nazario\",\"photoURL\":\"https://api.adorable.io/avatars/285/a12.png\"},{\"id\":13,\"name\":\"Judar Lima\",\"photoURL\":\"https://api.adorable.io/avatars/285/a13.png\"}]".data(using: .utf8, allowLossyConversion: true) else {
                    completion(nil, nil)
                    return
                }
                
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([Contact].self, from: jsonData)
                
                DispatchQueue.main.async {
                    completion(decoded, nil)
                }
            } catch let error {
                debugPrint("[Service] -----> \(error)")
                completion(nil, error)
            }
        }
    }
}
