//
//  NSDateFormatter+Extension.swift
//  WeatherGuard
//
//  Created by Reenen du Plessis on 2023/08/07.
//

import Foundation

extension DateFormatter {
    static let yearMonthDayTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()

    static let readableDayMonthYearTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm, d MMMM y"
        return formatter
    }()

    static func convertDateStringToHumanReadable(string: String?) -> String? {
        guard let safeString = string,
              let date = yearMonthDayTime.date(from: safeString) else { return nil }
        return readableDayMonthYearTime.string(from: date)
    }

    static func durationBewteen(startDateString: String?, endDateString: String?) -> String? {
        guard let startDateString = startDateString,
              let endDateString = endDateString,
        let startDate = yearMonthDayTime.date(from: startDateString),
        let endDate = yearMonthDayTime.date(from: endDateString) else {
            return nil
        }

        return startDate.humanReadableHoursSince(date: endDate)
    }
}
