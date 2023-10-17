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

struct Contact: Decodable {
    let id: Int
    let name: String
    let photoURL: String
}
