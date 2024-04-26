//
//  LocationMapView.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 21.05.2023.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import SwiftUI
import MapKit

struct LocationMapView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50.073658, longitude: 14.418540),
                                                   span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Spacer()
                    Image("ddg-map-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 70)
                        .shadow(radius: 10)
                    Spacer()
                }
                .padding(.top, 50)
                .background(Color.secondary)
                
                Spacer()
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    LocationMapView()
}
