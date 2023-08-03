import Foundation

extension URLSession {
    func performCodableRequestTask<T: Codable>(with request: URLRequest,
                                               completion: @escaping (T?, URLResponse?, Error?) -> Void) {
        let task = self.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data,
                      error == nil else {
                    completion(nil, response, error)
                    return
                }
                completion(try? JSONDecoder().decode(T.self, from: data), response, nil)
            }
        }

        task.resume()
    }
}
