import Foundation

struct NetworkContactDataSource: ContactDataSourceType {

    let httpClient: HTTPClientType

    init(httpClient: HTTPClientType) {
        self.httpClient = httpClient
    }

    func getAll(completion: @escaping (Result<[Contact], Error>) -> Void) {
        httpClient.execute(request: .fetchContacts()) { result in
            switch result {
            case .success(let data):
                completion(Contact.mapToResult(data: data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
