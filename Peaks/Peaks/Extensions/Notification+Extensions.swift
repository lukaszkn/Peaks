//
//  Notification+Extensions.swift
//  WalkStreets
//
//  Created by Lukasz on 21/03/2024.
//
// https://medium.com/@JoyceMatos/using-nsnotificationcenter-in-swift-eb70cf0b60fc
// https://www.tutorialspoint.com/nsnotificationcenter-addobserver-in-swift

import Foundation

extension Notification.Name {
    static let didUpdateLocation = Notification.Name("didUpdateLocation")
    static let locationManagerDidChangeAuthorization = Notification.Name("locationManagerDidChangeAuthorization")
    static let mainTabIndexChangeRequest = Notification.Name("mainTabIndexChangeRequest")
}
