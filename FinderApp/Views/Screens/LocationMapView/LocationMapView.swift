//
//  LocationMapView.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 21.05.2023.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import SwiftUI
import MapKit

struct LocationMapView: View {
    @EnvironmentObject private var locationManager: LocationManager
    @StateObject private var viewModel = LocationMapViewModel()
    @State private var selectedTab: String = "map"
    var body: some View {
        ZStack(alignment: .bottom) {
            Color("brandSelego").ignoresSafeArea()
            ZStack {
                Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: locationManager.locations) { location in
                    MapMarker(coordinate: location.location.coordinate, tint: .brandPrimary)
                }
                .ignoresSafeArea()
                
                VStack {
                    LogoView().shadow(radius: 10)
                    Spacer()
                }
            }
            .alert(item: $viewModel.alertItem, content: { alertItem in
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
            })
            .onAppear {
                viewModel.checkLocationServicesIsEnabled()
                
                if locationManager.locations.isEmpty {
                    viewModel.getLocations(for: locationManager)
                }
            }
            CustomTabBar(selectedTab: $selectedTab)
        }
    }
}

#Preview {
    LocationMapView()
}

struct LogoView: View {
    var body: some View {
        Image("ddg-map-logo")
            .resizable()
            .scaledToFit()
            .frame(height: 70)
    }
}
