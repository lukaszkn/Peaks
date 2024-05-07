//
//  MapDataSource.swift
//  PeaksTrails
//
//  Created by Lukasz on 23/04/2024.
//

import Foundation
import MapKit
import ClusterMap

struct PeakMarker: Identifiable, CoordinateIdentifiable, Hashable {
    var id: Int64
    var coordinate: CLLocationCoordinate2D
    var name: String
}

@Observable class MapDataSource {
    var peaks: [PeakMarker] = []
    var hikingPolylines: [MKPolyline] = []
    
    var mapSize: CGSize = .zero
    var currentRegion: MKCoordinateRegion? = nil
    
    func addPeaks(_ peaksToAdd: [Peak]) async {
        let newPeaks = peaksToAdd.map { peak in
            PeakMarker(id: peak.id, coordinate: CLLocationCoordinate2DMake(Double(peak.latitude), Double(peak.longitude)), name: peak.name)
        }
        peaks = newPeaks
    }
    
    func reloadAnnotations() async {
        if let region = currentRegion {
            let maxDegree = max(region.span.longitudeDelta, region.span.latitudeDelta)
            print("maxDegree = \(maxDegree)") // 1 for hiking relations
            

        }
    }
    
    func addPointsGroup(_ pointsGroup: [CLLocation]) -> MKPolyline? {
        if pointsGroup.count > 1 {
            let points = pointsGroup.map { loc in
                loc.coordinate
            }
            return MKPolyline(coordinates: points, count: points.count)
        }
        return nil
    }
}
