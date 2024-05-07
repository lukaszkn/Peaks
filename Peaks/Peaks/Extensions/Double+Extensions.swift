//
//  Double+Extensions.swift
//  WalkStreets
//
//  Created by Lukasz on 02/04/2024.
//

import Foundation
import CoreLocation

extension Double {
    func distanceString() -> String {
        let distanceInMeters: CLLocationDistance = self

        if Locale.current.measurementSystem == .metric {
            return NSString(format: "%.0fm", self) as String
        } else {
            let yards = Measurement(value: distanceInMeters, unit: UnitLength.meters).converted(to: UnitLength.yards).value
            if yards > 50 {
                let formatter = MeasurementFormatter()
                return formatter.string(from: Measurement(value: distanceInMeters, unit: UnitLength.meters))
            } else {
                return NSString(format: "%.0fyd", yards) as String
            }
        }
    }
    
    func distanceLongString() -> String {
        let distanceInMeters: CLLocationDistance = self
        
        if Locale.current.measurementSystem == .metric {
            return NSString(format: "%.1fkm", self / 1000.0) as String
        } else {
            let formatter = MeasurementFormatter()
            return formatter.string(from: Measurement(value: distanceInMeters, unit: UnitLength.meters))
        }
    }
    
    func expectedTravelTimeString() -> String {
        NSString(format: "%.0f min", self / 60.0) as String
    }
    
    func timeIntervalString() -> String {
        // https://cocoacasts.com/cocoa-fundamentals-formatting-a-time-interval-in-swift
        let formatter = DateComponentsFormatter()
        
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        
        return formatter.string(from: self)!
    }
    
    func angleGrid() -> Int {
        return self > 1000 ? 0 : self < -1000 ? 0 : Int(self / 0.1)
    }
}
//
//extension Float {
//    func angleGrid() -> Int {
//        return Int(self / 0.01)
//    }
//}
