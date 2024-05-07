//
//  Bundle+Extensions.swift
//  MonitoringPowodziowy
//
//  Created by Lukasz on 24/05/2023.
//

import Foundation

// https://www.hackingwithswift.com/articles/141/8-useful-swift-extensions
// https://developer.apple.com/tutorials/swiftui/building-lists-and-navigation
extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from filename: String) -> T {
        guard let json = url(forResource: filename, withExtension: nil) else {
            fatalError("Failed to locate \(filename) in app bundle.")
        }

        guard let jsonData = try? Data(contentsOf: json) else {
            fatalError("Failed to load \(filename) from app bundle.")
        }

        let decoder = JSONDecoder()


        do {
            let result = try decoder.decode(T.self, from: jsonData)
            return result
        } catch {
            print("JSONDecoder error \(error)")
        }

        guard let result = try? decoder.decode(T.self, from: jsonData) else {
            fatalError("Failed to decode \(filename) from app bundle.")
        }
        return result
    }
}
