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
    
    @Published var checkedInProfiles: [DDGProfile] = []
    @Published var isShowingProfileModel = false
    @Published var isCheckedIn = false
    @Published var isLoading = false
    @Published var alertItem: AlertItem?
    
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
    
    func getCheckedInStatus() -> Void {
        guard let profileRecordID = CloudKitManager.shared.profileRecordID else { return }
        
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let record):
                    if let reference = record[DDGProfile.kIsCheckedIn] as? CKRecord.Reference {
                        self.isCheckedIn = reference.recordID == self.location.id
                    } else {
                        self.isCheckedIn = false
                    }
                case .failure(_):
                    self.alertItem = AlertContext.unableToGetCheckInStatus
                }
            }
        }
    }
    
    func updateCheckInStatus(to checkInStatus: CheckInStatus) {
        guard let profileRecordID = CloudKitManager.shared.profileRecordID else {
            alertItem = AlertContext.unabelToGetProfile
            return
        }
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
                    
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let record):
                            let profile = DDGProfile(record: record)
                            switch checkInStatus {
                            case .checedIn:
                                self.checkedInProfiles.append(profile)
                            case .checkedOut:
                                self.checkedInProfiles.removeAll(where: {$0.id == profile.id})
                            }
                            
                            self.isCheckedIn = checkInStatus == .checedIn
                            
                            print("✅ Checked In/Out Successfully")
                        case .failure(_):
                            self.alertItem = AlertContext.unableToCheckInOrOut
                            print("❌ Error saving record")
                        }
                    }
                }
            case .failure(_):
                self.alertItem = AlertContext.unableToCheckInOrOut
                print("❌ Error fetching record")
            }
        }
    }
    
    func getCheckedInProfiles() -> Void {
        showLoadingView()
        CloudKitManager.shared.getCheckedInProfiles(for: location.id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let profiles):
                    self.checkedInProfiles = profiles
                case .failure(_):
                    self.alertItem = AlertContext.unableToGetCheckedInProfiles
                }
                
                self.hideLoadingView()
            }
        }
    }
    
    private func showLoadingView() { isLoading = true }
    private func hideLoadingView() { isLoading = false }
}
