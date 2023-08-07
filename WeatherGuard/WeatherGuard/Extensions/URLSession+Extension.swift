import Foundation

extension URLSession {
    func performCodableRequestTask<T: Codable>(with request: URLRequest,
                                               completion: @escaping (T?, URLResponse?, Error?) -> Void) {
        let task = self.dataTask(with: request) { data, response, error in
            guard let data = data,
                  error == nil else {
                DispatchQueue.main.async {
                    completion(nil, response, error)
                }
                return
            }

            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(result, response, nil)
                }
            }
            catch {
                DispatchQueue.main.async {
                    completion(nil, response, error)
                }
            }
        }

        task.resume()
    }
}
