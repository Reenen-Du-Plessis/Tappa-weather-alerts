import Foundation

protocol AlertsFetchable {
    func getAlerts(completion: @escaping ([AlertModel?], URLResponse?,  Error?) -> Void)
}

protocol AlertModel {
    var effective: String? { get }
    var ends: String? { get }
    var event: String? { get }
    var senderName: String? { get }
}

class WeatherAlertsNetworkClient: AlertsFetchable {
    func getAlerts(completion: @escaping ([AlertModel?], URLResponse?,  Error?) -> Void) {
        let url = endPoint().url

        NetworkClient.performGetRequest(for: url) { (result: WeatherAlerts?, response, error) in
            let alertModels = result?.features?.map { $0.properties }
            let unwrappedModels = alertModels ?? []
            completion(unwrappedModels, response, error)
        }
    }

    func endPoint() -> Endpoint {
        var queryItems: [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "status", value: "actual"))
        queryItems.append(URLQueryItem(name: "message_type", value: "alert"))

        return Endpoint(path: Endpoints.activeAlerts,
                        queryItems: queryItems)
    }
}
