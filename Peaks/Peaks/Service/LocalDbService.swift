//
//  LocalDbService.swift
//  PeaksTrails
//
//  Created by Lukasz on 23/04/2024.
//

import Foundation
import SQLite
import MapKit

class LocalDbService {
    lazy var dbPath = Bundle.main.url(forResource: "peaks-poland", withExtension: "sqlite3")!.absoluteString
    
    func getPeaks() async -> [Peak] {
        var peaks: [Peak] = []
        
        do {
            let db = try Connection(dbPath, readonly: true)
            
            let peakTable = Table("peak")
            let peakId = Expression<Int64>("id")
            let peakName = Expression<String>("name")
            let peakIntName = Expression<String>("int_name")
            let peakLatitude = Expression<Double>("lat")
            let peakLongitude = Expression<Double>("lng")
            let peakEle = Expression<Double>("ele")
            let peakWikidata = Expression<String>("wikidata")
            let peakWikipedia = Expression<String>("wikipedia")
            
            let peaksQuery = peakTable.select(peakId, peakName, peakIntName, peakLatitude, peakLongitude, peakEle, peakWikidata, peakWikipedia)
            
            for peakRow in try db.prepare(peaksQuery) {
                peaks.append(Peak(id: peakRow[peakId], name: peakRow[peakName], int_name: peakRow[peakIntName],
                                  longitude: Float(peakRow[peakLongitude]), latitude: Float(peakRow[peakLatitude]),
                                  ele: Float(peakRow[peakEle]),
                                  wikidata: peakRow[peakWikidata], wikipedia: peakRow[peakWikipedia]))
            }
            
            return peaks
        } catch {
            print("getPeaks error \(error)")
        }
        
        return []
    }
    
}
