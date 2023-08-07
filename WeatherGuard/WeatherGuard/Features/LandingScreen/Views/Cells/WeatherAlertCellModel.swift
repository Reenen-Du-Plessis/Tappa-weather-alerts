import Foundation
import UIKit

protocol WeatherAlertCellModel: Hashable {
    var title: String? { get }
    var duration: String? { get }
    var start: String? { get }
    var end: String? { get }
    var source: String? { get }
    var image: UIImage? { get }

    func fetchImage(completion: @escaping (Bool) -> Void)
}

class WeatherAlertCollectionViewCellModel: WeatherAlertCellModel {
    static func == (lhs: WeatherAlertCollectionViewCellModel, rhs: WeatherAlertCollectionViewCellModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    var id: UUID = UUID()
    var title: String?
    var duration: String?
    var start: String?
    var end: String?
    var source: String?
    var image: UIImage? = nil
    var imageURL: URL?

    init(title: String? = nil, duration: String? = nil, start: String? = nil, end: String? = nil, source: String? = nil, imageURL: URL? = nil) {
        self.title = title
        self.duration = duration
        self.start = start
        self.end = end
        self.source = source
        self.imageURL = imageURL
    }

    func fetchImage(completion: @escaping (Bool) -> Void) {
        if image == nil {
            NetworkClient.performImageRequest(for: URL(string: "https://picsum.photos/1000")) { [weak self] (image, response, error) in
                if let image = image {
                    self?.image = image
                    completion(true)
                }
                completion(false)
            }
        }
    }
}
