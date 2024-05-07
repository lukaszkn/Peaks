//
//  MapView.swift
//  PeaksTrails
//
//  Created by Lukasz on 23/04/2024.
//

import SwiftUI
import _MapKit_SwiftUI
import ClusterMapSwiftUI

struct MapView: View {
    var dataSource: MapDataSource
    
    var body: some View {
        Map(interactionModes: .all) {
            ForEach(dataSource.peaks) { peak in
                Marker(peak.name, coordinate: peak.coordinate)
            }
            
            ForEach(dataSource.hikingPolylines, id: \.self) { track in
                MapPolyline(track)
                    .stroke(.blue, lineWidth: 2)
            }
            
            UserAnnotation()
        }
        .mapControls() {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
            MapPitchToggle()
        }
        .readSize(onChange: { newValue in
            dataSource.mapSize = newValue
        })
        .onMapCameraChange { camera in
            dataSource.currentRegion = camera.region
        }
        .onMapCameraChange(frequency: .onEnd) { context in
            Task.detached { await dataSource.reloadAnnotations() }
        }
    }
}

