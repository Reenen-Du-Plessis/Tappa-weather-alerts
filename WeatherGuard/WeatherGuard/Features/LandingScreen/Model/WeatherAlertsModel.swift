import Foundation

struct WeatherAlerts: Codable {
    let type: String?
    let features: [Feature]?
    let title: String?
    let updated: Date?

    enum CodingKeys: String, CodingKey {
        case type, features, title, updated
    }
}

struct Feature: Codable {
    let id: String?
    let type: String?
    let properties: Properties?
}

struct Properties: Codable {
    let id: String?
    let effective: Date?
    let ends: Date?
    let event: String?
    let senderName: String?

    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case effective, ends, event, senderName
    }
}

extension WeatherAlerts {
    static func getAlerts(completion: @escaping (WeatherAlerts?, URLResponse?,  Error?) -> Void) {
        let url = WeatherAlerts.endPoint().url

        NetworkClient.performGetRequest(for: url,
                                        completion: completion)
    }

    static func endPoint() -> Endpoint {
        var queryItems: [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "status", value: "actual"))
        queryItems.append(URLQueryItem(name: "message_type", value: "alert"))

        return Endpoint(path: Endpoints.activeAlerts,
                        queryItems: queryItems)
    }
}
