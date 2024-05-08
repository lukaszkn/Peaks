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

struct PeakClusterAnnotation: Identifiable {
    var id = UUID()
    var coordinate: CLLocationCoordinate2D
    var count: Int
}

@Observable class MapDataSource {
    private let clusterManager: ClusterManager<PeakMarker>
    
    var peaks: [PeakMarker] = []
    var peakClusters: [PeakClusterAnnotation] = []
    var hikingPolylines: [MKPolyline] = []
    
    var mapSize: CGSize = .zero
    var currentRegion: MKCoordinateRegion = .init(center: CLLocationCoordinate2D(latitude: 51.9517, longitude: 18.8), span: MKCoordinateSpan(latitudeDelta: 13.2426, longitudeDelta: 11.6120))
    
    init() {
        let clusterConfiguration = ClusterManager<PeakMarker>.Configuration(
            minCountForClustering: 3
        )
        
        clusterManager = ClusterManager<PeakMarker>(configuration: clusterConfiguration)
    }
    
    func addPeaks(_ peaksToAdd: [Peak]) async {
        let newPeaks = peaksToAdd.map { peak in
            PeakMarker(id: peak.id, coordinate: CLLocationCoordinate2DMake(Double(peak.latitude), Double(peak.longitude)), name: peak.name)
        }
        
        await clusterManager.add(newPeaks)
        await reloadAnnotations()
    }
    
    func reloadAnnotations() async {
        //if let region = currentRegion {
            //await MainActor.run { }
            
            let changes = await clusterManager.reload(mapViewSize: mapSize, coordinateRegion: currentRegion)
            await applyChanges(changes)
        //}
    }
    
    @MainActor
    private func applyChanges(_ difference: ClusterManager<PeakMarker>.Difference) {
        for removal in difference.removals {
            switch removal {
            case .annotation(let annotation):
                peaks.removeAll { $0 == annotation }
            case .cluster(let clusterAnnotation):
                peakClusters.removeAll { $0.id == clusterAnnotation.id }
            }
        }
        for insertion in difference.insertions {
            switch insertion {
            case .annotation(let newItem):
                peaks.append(newItem)
                
            case .cluster(let newItem):
                peakClusters.append(PeakClusterAnnotation(
                    id: newItem.id,
                    coordinate: newItem.coordinate,
                    count: newItem.memberAnnotations.count)
                )
            }
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
