import Foundation


class ListContactService {
    
    static let shared = ListContactService()
    private let session: URLSessionProtocol
    
    private init() {
        self.session = URLSession.shared
    }
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func fetchContacts() async throws -> [Contact] {
        guard let api = URL(string: ContactStrings.contactApiURL) else {
            throw ContactErrors.invalidURL
        }
        
        let (data, response) = try await session.data(for: URLRequest(url: api))
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw ContactErrors.invalidRequest
        }
        
        return try JSONDecoder().decode([Contact].self, from: data)
    }
}

