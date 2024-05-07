//
//  Peak.swift
//  PeaksTrails
//
//  Created by Lukasz on 23/04/2024.
//

import Foundation
class Peak: Codable, Identifiable {
    var id: Int64
    var name: String
    var int_name: String?
    var longitude: Float
    var latitude: Float
    var ele: Float
    var wikidata: String
    var wikipedia: String
    
    init(id: Int64, name: String, int_name: String? = nil, longitude: Float, latitude: Float, ele: Float, wikidata: String, wikipedia: String) {
        self.id = id
        self.name = name
        self.int_name = int_name
        self.longitude = longitude
        self.latitude = latitude
        self.ele = ele
        self.wikidata = wikidata
        self.wikipedia = wikipedia
    }
}
