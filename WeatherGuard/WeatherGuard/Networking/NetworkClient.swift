import Foundation
import CoreLocation
import UIKit

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

    static func performImageRequest(for url: URL?,
                                       completion: @escaping (UIImage?, URLResponse?, Error?) -> Void) {
        guard let url = url else {
            completion(nil, nil, nil)
            return
        }

        let request = getRequest(with: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil, response, error)
                }
                return
            }

            DispatchQueue.main.async() {
                let image = UIImage(data: data)
                completion(image, response, nil)
            }
        }
        task.resume()
    }
}
