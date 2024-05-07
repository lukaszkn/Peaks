//
//  MainContentView.swift
//  PeaksTrails
//
//  Created by Lukasz on 23/04/2024.
//

import SwiftUI

struct MainContentView: View {
    enum TabIndex: Int {
        case map = 0
    }
    
    var body: some View {
        TabView {
            MapTabView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
                .tag(TabIndex.map.rawValue)
        }
    }
}

#Preview {
    MainContentView()
}
