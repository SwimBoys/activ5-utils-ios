//
//  File.swift
//  
//
//  Created by Martin Kuvandzhiev on 13.08.20.
//

import Foundation

public extension DateFormatter {
    enum Format: String {
        case imperial = "MM/dd/yyyy"
        case metric = "dd/MM/yyyy"
        case iso = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        case birthday = "yyyy-MM-dd"
        
        var dateFormatter: DateFormatter {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = self.rawValue
            return dateFormatter
        }
        
        var isoDateFormatter: ISO8601DateFormatter {
            let isoDateFormatter = ISO8601DateFormatter()
            isoDateFormatter.timeZone = TimeZone.current
            if #available(iOS 11.0, *) {
                isoDateFormatter.formatOptions = [
                    .withFullDate,
                    .withFullTime,
                    .withDashSeparatorInDate,
                    .withFractionalSeconds]
            } else {
                // Fallback on earlier versions
            }
            return isoDateFormatter
        }
    }
    
    static let imperial: DateFormatter = Format.imperial.dateFormatter
    static let metric: DateFormatter = Format.metric.dateFormatter
    static let iso: ISO8601DateFormatter = Format.iso.isoDateFormatter
    static let birthday: DateFormatter = Format.birthday.dateFormatter
}

public extension Date {
    init?(imperial string: String) {
        self.init(string: string, format: .imperial)
    }
    
    init?(metric string: String) {
        self.init(string: string, format: .metric)
    }
    
    init?(iso string: String) {
        self.init(string: string, format: .iso)
    }
    
    init?(birthdate string: String) {
        self.init(string: string, format: .birthday)
    }
    
    init?(string: String, format: DateFormatter.Format) {
        switch format {
        case .iso:
            guard let date = format.isoDateFormatter.date(from: string) else {
                return nil
            }
            self.init(timeIntervalSince1970: date.timeIntervalSince1970)
        default:
            guard let date = format.dateFormatter.date(from: string) else {
                return nil
            }
            self.init(timeIntervalSince1970: date.timeIntervalSince1970)
        }
    }
    
    func string(format: DateFormatter.Format) -> String {
        format.dateFormatter.string(from: self)
    }
    
    var imperialString: String {
        return DateFormatter.Format.imperial.dateFormatter.string(from: self)
    }
    
    var metricString: String {
        return DateFormatter.Format.metric.dateFormatter.string(from: self)
    }
    
    var isoString: String {
        return DateFormatter.Format.iso.dateFormatter.string(from: self)
    }
    
    var birthdayString: String {
        return DateFormatter.Format.birthday.dateFormatter.string(from: self)
    }
}

public extension String {
    func asDate(format: DateFormatter.Format) -> Date? {
        return Date(string: self, format: format)
    }
}
