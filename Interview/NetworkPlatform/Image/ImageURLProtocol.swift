import Foundation

class ImageURLProtocol: URLProtocol {
    static var urlSession: URLSession = URLSession(configuration: URLSessionConfiguration.ephemeral)
}
