//
//  LocationMapViewModel.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 04.05.2024.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import MapKit

final class LocationMapViewModel: NSObject, ObservableObject {
    
    @Published var isShowingOnboardView = false
    @Published var alertItem: AlertItem?
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 49.747438, longitude: 13.377562), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    var deviceLocationManager: CLLocationManager?
    let kHasSeenOnboardView = "hasSeenOnboardView"
    
    var hasSeenOnboardView: Bool {
        return UserDefaults.standard.bool(forKey: kHasSeenOnboardView)
    }
    
    func runStartupChecks() -> Void {
        if !hasSeenOnboardView {
            isShowingOnboardView = true
            UserDefaults.standard.setValue(true, forKey: kHasSeenOnboardView)
        } else {
            checkLocationServicesIsEnabled()
        }
    }
    
    func checkLocationServicesIsEnabled() -> Void {
        if CLLocationManager.locationServicesEnabled() {
            deviceLocationManager = CLLocationManager()
            deviceLocationManager!.delegate = self
        } else {
            alertItem = AlertContext.locationDisabled
        }
    }
    
    private func checkLocationAuthorization() -> Void {
        guard let deviceLocationManager = deviceLocationManager else { return }
        switch deviceLocationManager.authorizationStatus {
        case .notDetermined:
            deviceLocationManager.requestWhenInUseAuthorization()
        case .restricted:
            alertItem = AlertContext.locationRestricted
        case .denied:
            alertItem = AlertContext.locationDenied
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
    
    func getLocations(for locationManager: LocationManager) -> Void {
        CloudKitManager.shared.getLocations { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let locations):
                    locationManager.locations = locations
                case .failure(_):
                    alertItem = AlertContext.unableToGetLocations
                }
            }
        }
    }
}

extension LocationMapViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
