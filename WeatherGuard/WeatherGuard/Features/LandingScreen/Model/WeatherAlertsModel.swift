import Foundation

struct WeatherAlerts: Codable {
    let type: String?
    let features: [Feature]?
    let title: String?
    let updated: String?

    enum CodingKeys: String, CodingKey {
        case type, features, title, updated
    }
}

struct Feature: Codable {
    let id: String?
    let type: String?
    let properties: Properties?
}

struct Properties: AlertModel, Codable {
    let id: String?
    let effective: String?
    let ends: String?
    let event: String?
    let senderName: String?

    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case effective, ends, event, senderName
    }
}
