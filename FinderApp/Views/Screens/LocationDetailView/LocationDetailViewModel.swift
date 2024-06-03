//
//  LocationDetailViewModel.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 29.05.2024.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import MapKit
import SwiftUI
import CloudKit

enum CheckInStatus { case checedIn, checkedOut }

final class LocationDetailViewModel: ObservableObject {
    
    @Published var alertItem: AlertItem?
    @Published var isShowingProfileModel = false
    
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]
    
    var location: DDGLocation
    
    init(location: DDGLocation) {
        self.location = location
    }
    
    func getDirectionstoLocation() -> Void {
        let placemark = MKPlacemark(coordinate: location.location.coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = location.name
        
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking])
    }
    
    func callLocation() -> Void {
        guard let url = URL(string: "tel://\(location.phoneNumber)") else {
            alertItem = AlertContext.invalidePhoneNumber
            return
        }
        
        UIApplication.shared.open(url)
    }
    
    func updateCheckInStatus(to checkInStatus: CheckInStatus) {
        guard let profileRecordID = CloudKitManager.shared.profileRecordID else { return }
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { [self] result in
            switch result {
            case .success(let record):
                switch checkInStatus {
                case .checedIn:
                    record[DDGProfile.kIsCheckedIn] = CKRecord.Reference(recordID: location.id, action: .none)
                case .checkedOut:
                    record[DDGProfile.kIsCheckedIn] = nil
                }
                
                CloudKitManager.shared.save(record: record) { result in
                    switch result {
                    case .success(_):
                        print("✅ Checked In/Out Successfully")
                    case .failure(let failure):
                        print("❌ Error saving record")
                    }
                }
            case .failure(let failure):
                print("❌ Error fetching record")
            }
        }
    }
}
