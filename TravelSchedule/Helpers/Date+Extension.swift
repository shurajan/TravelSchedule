//
//  Date+Extension.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 13.01.2025.
//

import Foundation

extension Date {
    
    static let dateFormatter = newDateFormatter()
    static let ISODateFormatter = newISODateFormatter()
    static let shortDateFormatter = newShortDateFormatter()
    static let dayMonthFormatter = newDayMonthFormatter()
    
    private static func newDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }
    
    private static func newISODateFormatter() -> ISO8601DateFormatter {
        let formatter = ISO8601DateFormatter()
        return formatter
    }
    
    private static func newShortDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        return formatter
    }
    
    private static func newDayMonthFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }
    
    private static func timeFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    var dateString: String {
        return Date.dateFormatter.string(from: self)
    }
    
    var shortDateString: String {
        return Date.shortDateFormatter.string(from: self)
    }
    
    var shortTimeString: String {
        return Date.timeFormatter().string(from: self)
    }
    
    var timeStampString: String {
        return Date.ISODateFormatter.string(from: self)
    }
    
    var dayMonthString: String {
        return Date.dayMonthFormatter.string(from: self)
    }
    
    func startOfDay() -> Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    func isSameDay(as date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: date)
    }
}

extension Date {
    enum TimeOfDay: String, CaseIterable, Sequence {
        case morning = "Утро"
        case day = "День"
        case evening = "Вечер"
        case night = "Ночь"
        
        var timeRange: String {
            switch self {
            case .morning:
                return "06:00 - 12:00"
            case .day:
                return "12:00 - 18:00"
            case .evening:
                return "18:00 - 00:00"
            case .night:
                return "00:00 - 06:00"
            }
        }
        
        var description: String {
            return "\(self.rawValue) \(timeRange)"
        }
        
        func makeIterator() -> AnyIterator<TimeOfDay> {
            var allCasesIterator = TimeOfDay.allCases.makeIterator()
            return AnyIterator {
                return allCasesIterator.next()
            }
        }
    }
    
    var timeOfDay: TimeOfDay {
        let hour = Calendar.current.component(.hour, from: self)
        switch hour {
        case 6..<12:
            return .morning
        case 12..<18:
            return .day
        case 18..<24:
            return .evening
        default:
            return .night
        }
    }
}
