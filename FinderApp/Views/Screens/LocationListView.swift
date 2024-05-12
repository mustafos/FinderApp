//
//  LocationListView.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 21.05.2023.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import SwiftUI

struct LocationListView: View {
    @EnvironmentObject private var locationManager: LocationManager
    
    var body: some View {
        NavigationView {
            List {
                ForEach(locationManager.locations) { location in
                    NavigationLink {
                        LocationDetailView(location: location)
                    } label: {
                        LocationCell(location: location)
                    }
                }
            }.navigationTitle("Finder Spots")
        }
    }
}

#Preview {
    LocationListView()
}
