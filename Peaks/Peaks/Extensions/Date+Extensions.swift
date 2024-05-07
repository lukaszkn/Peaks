//
//  Date+Extensions.swift
//  WalkStreets
//
//  Created by Lukasz on 15/04/2024.
//
// https://stackoverflow.com/questions/44009804/swift-3-how-to-get-date-for-tomorrow-and-yesterday-take-care-special-case-ne

import Foundation

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    
    var dayBefore: Date {
        return Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: -1, to: noon)!)
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}
