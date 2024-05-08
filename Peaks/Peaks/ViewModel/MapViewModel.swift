//
//  MapViewModel.swift
//  PeaksTrails
//
//  Created by Lukasz on 23/04/2024.
//

import Foundation
import _MapKit_SwiftUI

@Observable class MapViewModel {
    var position: MapCameraPosition = .userLocation(fallback: .automatic)
    var mapDataSource = MapDataSource()
    
    func onAppear() {
        Task {
            let db = LocalDbService()
            let peaks = await db.getPeaks()
            
            await self.mapDataSource.addPeaks(peaks)
        }
    }
}
