//
//  Import.swift
//  PeaksTrailsTests
//
//  Created by Lukasz on 18/04/2024.
//

import Foundation
import XCTest
@testable import Peaks
import SQLite

final class Import: XCTestCase {
    func testImportPoland() throws {
        try importData(peaksFilename: "poland-peaks.json")
    }
    
    func importData(peaksFilename: String) throws {

        let start = CFAbsoluteTimeGetCurrent()
        let path = getDocumentsDirectory().appending(path: "peaks-poland.sqlite3")
        do {
            do {
                try FileManager.default.removeItem(at: path)
                print("Database Deleted!")
            } catch {
                print("Error on Delete Database!!! \(error)")
            }
            
            let db = try Connection(path.absoluteString)
            print("db path \(path)")
            
            // peaks
            let peakTable = Table("peak")
            let peakId = Expression<Int64>("id")
            let peakName = Expression<String>("name")
            let peakIntName = Expression<String>("int_name")
            let peakLatitude = Expression<Double>("lat")
            let peakLongitude = Expression<Double>("lng")
            let peakEle = Expression<Double>("ele")
            let peakWikidata = Expression<String>("wikidata")
            let peakWikipedia = Expression<String>("wikipedia")
            
            try db.run(peakTable.create { t in
                t.column(peakId)
                t.column(peakName)
                t.column(peakIntName)
                t.column(peakLatitude)
                t.column(peakLongitude)
                t.column(peakEle)
                t.column(peakWikidata)
                t.column(peakWikipedia)
            })
            
            let peaks = Bundle(for: Import.self).decode([Peak].self, from: peaksFilename)
            try db.transaction {
                for peak in peaks {
                    let insertPeak = peakTable.insert(peakId <- peak.id, peakName <- peak.name, peakIntName <- peak.int_name ?? "",
                                                      peakLatitude <- Double(peak.latitude), peakLongitude <- Double(peak.longitude),
                                                      peakEle <- Double(peak.ele),
                                                      peakWikidata <- peak.wikidata, peakWikipedia <- peak.wikipedia
                    )
                    try db.run(insertPeak)
                }
            }
            
            try db.vacuum()
            if let fileAttributes = try? FileManager.default.attributesOfItem(atPath: path.path()), let bytes = fileAttributes[.size] as? Int64 {
                let bcf = ByteCountFormatter()
                bcf.allowedUnits = [.useMB]
                bcf.countStyle = .file
                
                print("size \(bcf.string(fromByteCount: bytes))")
            }
        } catch  {
            print("importData \(error)")
        }
        let diff = CFAbsoluteTimeGetCurrent() - start
        print("importData took \(diff)")
    }
    
    enum ImportError: Error {
        case runtimeError(String)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}
