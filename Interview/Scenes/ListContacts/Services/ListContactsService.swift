import Foundation

/******************* SERVICE ********************/
class ListContactService {
    func fetchContacts(completion: @escaping ([Contact]?, Error?) -> Void) {
        /// Usa URLSession para acessar a API e retorna
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(fakeList, nil)
        }
    }
}
