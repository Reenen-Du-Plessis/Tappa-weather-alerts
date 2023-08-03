import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]

    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Endpoints.host
        components.path = path
        components.queryItems = queryItems

        return components.url
    }
}

enum Endpoints {
    static let host = "api.weather.gov"
    static let activeAlerts = "/alerts/active"
}
