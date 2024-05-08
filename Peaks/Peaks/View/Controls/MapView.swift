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
        Map(initialPosition: .region(dataSource.currentRegion),
            interactionModes: .all) {
            ForEach(dataSource.peaks) { peak in
                Marker(peak.name, systemImage: "mountain.2.fill", coordinate: peak.coordinate)
            }
            
            // peaks clusters
            ForEach(dataSource.peakClusters) { cluster in
                Annotation(coordinate: cluster.coordinate) {
                    ZStack {
                        Circle()
                            .foregroundStyle(.green)
                            .frame(width: 30, height: 30)

                        Text("\(cluster.count)")
                            .font(.footnote)
                    }
                } label: {
                    EmptyView()
                }
                .annotationTitles(.hidden)
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

