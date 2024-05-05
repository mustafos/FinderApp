//
//  LocationMapViewModel.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 04.05.2024.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import MapKit

final class LocationMapViewModel: ObservableObject {
    @Published var alertItem: AlertItem?
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 49.747438, longitude: 13.377562),
                                                   span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    @Published var locations: [DDGLocation] = []
    
    func getLocations() -> Void {
        CloudKitManager.getLocations { [self] result in
            switch result {
            case .success(let locations):
                self.locations = locations
            case .failure(_):
                alertItem = AlertContext.unableToGetLocations
            }
        }
    }
}
