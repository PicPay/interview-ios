import Foundation

private let apiURL = "https://run.mocky.io/v3/c4ba296a-58af-4877-99bc-8d8589ae2171"

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

/*
[
  {
    "id": 1,
    "name": "Shakira",
    "photoURL": "https://api.adorable.io/avatars/285/a1.png"
  },
  {
    "id": 2,
    "name": "Beyonce",
    "photoURL": "https://api.adorable.io/avatars/285/a2.png"
  },
  {
    "id": 3,
    "name": "Tom Cruise",
    "photoURL": "https://api.adorable.io/avatars/285/a3.png"
  },
  {
    "id": 4,
    "name": "Tiririca",
    "photoURL": "https://api.adorable.io/avatars/285/a4.png"
  },
  {
    "id": 5,
    "name": "Steve Rogers",
    "photoURL": "https://api.adorable.io/avatars/285/a5.png"
  },
  {
    "id": 6,
    "name": "Steve Jobs",
    "photoURL": "https://api.adorable.io/avatars/285/a6.png"
  },
  {
    "id": 7,
    "name": "Scott Forstall",
    "photoURL": "https://api.adorable.io/avatars/285/a7.png"
  },
  {
    "id": 8,
    "name": "Craig Federighi",
    "photoURL": "https://api.adorable.io/avatars/285/a8.png"
  },
  {
    "id": 9,
    "name": "Steve Ballmer",
    "photoURL": "https://api.adorable.io/avatars/285/a9.png"
  },
  {
    "id": 10,
    "name": "Lucas Romano",
    "photoURL": "https://api.adorable.io/avatars/285/a10.png"
  },
  {
    "id": 11,
    "name": "Lucas Cypriano",
    "photoURL": "https://api.adorable.io/avatars/285/a11.png"
  },
  {
    "id": 12,
    "name": "Fernando Nazario",
    "photoURL": "https://api.adorable.io/avatars/285/a12.png"
  },
  {
    "id": 13,
    "name": "Judar Lima",
    "photoURL": "https://api.adorable.io/avatars/285/a13.png"
  }
]

*/
