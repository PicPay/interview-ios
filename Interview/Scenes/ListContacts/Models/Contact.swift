import Foundation

/******************* MODEL ********************/
class Contact: Decodable {
    var name: String = ""
    var photoURL = ""
    var id = ""
    
    init(name: String, photoURL: String, id: String) {
        self.name = name
        self.photoURL = photoURL
        self.id = id
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case photoURL = "photoURL"
        case id = "id"
    }
}

let fakeList: [Contact] = [
    Contact(name: "Shakira", photoURL: "https://api.adorable.io/avatars/285/a1.png", id: "a1"),
    Contact(name: "Beyonce", photoURL: "https://api.adorable.io/avatars/285/a2.png", id: "a2"),
    Contact(name: "Tom Cruise", photoURL: "https://api.adorable.io/avatars/285/a3.png", id: "a3"),
    Contact(name: "Tiririca", photoURL: "https://api.adorable.io/avatars/285/a4.png", id: "a4"),
    Contact(name: "Steve Rogers", photoURL: "https://api.adorable.io/avatars/285/a5.png", id: "a5"),
    Contact(name: "Steve Jobs", photoURL: "https://api.adorable.io/avatars/285/a6.png", id: "a6"),
    Contact(name: "Scott Forstall", photoURL: "https://api.adorable.io/avatars/285/a7.png", id: "a7"),
    Contact(name: "Craig Federighi", photoURL: "https://api.adorable.io/avatars/285/a8.png", id: "a8"),
    Contact(name: "Steve Ballmer", photoURL: "https://api.adorable.io/avatars/285/a9.png", id: "a9"),
    Contact(name: "Lucas Romano", photoURL: "https://api.adorable.io/avatars/285/a10.png", id: "a10"),
    Contact(name: "Lucas Cypriano", photoURL: "https://api.adorable.io/avatars/285/a11.png", id: "a11"),
    Contact(name: "Fernando Nazario", photoURL: "https://api.adorable.io/avatars/285/a12.png", id: "a12")
]
