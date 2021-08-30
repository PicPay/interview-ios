import Foundation

class Contact {
    var id: Int
    var name: String
    var photoURL: String

    init(id: Int, name: String, photoURL: String) {
        self.id = id
        self.name = name
        self.photoURL = photoURL
    }

    init() {
        id = 0
        name = ""
        photoURL = ""
    }
}
