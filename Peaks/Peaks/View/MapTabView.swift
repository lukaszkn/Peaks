//
//  MapTabView.swift
//  PeaksTrails
//
//  Created by Lukasz on 23/04/2024.
//

import SwiftUI

struct MapTabView: View {
    private var viewModel = MapViewModel()
    
    var body: some View {
        ZStack {
            MapView(dataSource: viewModel.mapDataSource)
        }
        .onAppear() {
            viewModel.onAppear()
        }
    }
}

#Preview {
    MapTabView()
}
