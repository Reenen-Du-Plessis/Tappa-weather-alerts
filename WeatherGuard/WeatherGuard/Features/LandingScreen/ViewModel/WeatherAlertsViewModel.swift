import Foundation

enum AlertSections {
    case list([AlertItem])
}

enum AlertItem {
    case longCard(any WeatherAlertCellModel)
}

protocol WeatherAlertsViewModel {
    var sections: [AlertSections] { get }
    func items(for section: Int) -> [AlertItem]
    func model(for indexPath: IndexPath) -> (any WeatherAlertCellModel)?
    func fetchData(completion: @escaping (Bool) -> Void)
    func reset()
}

class WeatherAlertsCollectionViewModel: WeatherAlertsViewModel {
    lazy var sections: [AlertSections] = {
        return createSections()
    }()

    private let networkClient: AlertsFetchable
    private var alerts: [AlertModel?] = []

    init(networkClient: AlertsFetchable) {
        self.networkClient = networkClient
    }

    private func createSections() -> [AlertSections] {
        var newSections: [AlertSections] = []
        let listSection = createListSection()
        newSections.append(listSection)
        return newSections
    }

    private func createListSection() -> AlertSections  {
        let rowItems = itemsForListSection()
        return AlertSections.list(rowItems)
    }

    func items(for section: Int) -> [AlertItem] {
        guard let sectionType = sections[safe: section] else { return [] }
        switch sectionType {
        case .list(let rows):
            return rows
        }
    }

    private func itemsForListSection() -> [AlertItem] {
        var newItems: [AlertItem] = []
        for alert in alerts {
            let cellModel = createCellModel(for: alert)
            newItems.append(.longCard(cellModel))
        }
        return newItems
    }

    func createCellModel(for alert: AlertModel?) -> any WeatherAlertCellModel {
        let start = DateFormatter.convertDateStringToHumanReadable(string: alert?.effective)
        let end = DateFormatter.convertDateStringToHumanReadable(string: alert?.ends)
        let duration = DateFormatter.durationBewteen(startDateString: alert?.effective, endDateString: alert?.ends)

        return WeatherAlertCollectionViewCellModel(title: alert?.event,
                                                   duration: duration,
                                                   start: start,
                                                   end: end,
                                                   source:  alert?.senderName, imageURL: URL(string: "https://picsum.photos/1000"))
    }

    func model(for indexPath: IndexPath) -> (any WeatherAlertCellModel)? {
        let sectionItems = items(for: indexPath.section)
        guard let itemType = sectionItems[safe: indexPath.row] else { return nil }
        switch itemType {
        case .longCard(let model):
            return model
        }
    }

    func fetchData(completion: @escaping (Bool) -> Void) {
        networkClient.getAlerts { [weak self] alerts, responesData, error in
            if let error = error {
                completion(false)
            } else {
                self?.alerts = alerts
                self?.reset()
                completion(false)
            }
        }
    }

    func reset() {
        self.sections = createSections()
    }
}
