import Foundation

/*
 Json Contract
[
  {
    "id": 1,
    "name": "Shakira",
    "photoURL": "https://api.adorable.io/avatars/285/a1.png"
  }
]
*/

class Contact: Codable {
    var id: Int
    var name: String = ""
    var photoURL = ""
    
    init(id: Int, name: String, photoURL: String) {
        self.id = id
        self.name = name
        self.photoURL = photoURL
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case photoURL = "photoURL"
        case id = "id"
    }
}
