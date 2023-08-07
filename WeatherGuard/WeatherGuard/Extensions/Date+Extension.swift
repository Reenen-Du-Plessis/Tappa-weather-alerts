import Foundation
extension Date {
    func components(to date: Date) -> DateComponents {
        let calendar = Calendar.current

        return calendar.dateComponents([.day, .hour, .minute, .second], from: self, to: date)
    }

    func humanReadableHoursSince(date: Date) -> String? {
        let components = components(to: date)
        guard let hours = components.hour,
              let minutes = components.minute,
              let seconds = components.second else { return nil }

        let hourString = hours > 1 ? "hours": "hour"
        let minuteString = minutes > 1 ? "minutes": "minute"
        let secondsString = seconds > 1 ? "seconds": "second"

        return "\(hours) \(hourString), \(minutes) \(minuteString), \(seconds) \(secondsString)"
    }
}
