import Foundation
import CoreLocation

class NetworkClient {
    static let timeOut = 30.0

    private static func getRequest(with url: URL) -> URLRequest {
        var request = URLRequest(url: url
                                 ,timeoutInterval: timeOut)
        request.httpMethod = "GET"
        return request
    }

    static func performGetRequest<T: Codable>(for url: URL?,
                                       completion: @escaping (T?, URLResponse?, Error?) -> Void) {
        guard let url = url else {
            completion(nil, nil, nil)
            return
        }

        let request = getRequest(with: url)
        URLSession.shared.performCodableRequestTask(with: request,
                                                    completion: completion)
    }
}
