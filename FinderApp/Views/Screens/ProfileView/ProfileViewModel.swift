//
//  ProfileViewModel.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 18.05.2024.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import CloudKit

enum ProfileContext { case create, update }

final class ProfileViewModel: ObservableObject {
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var companyName: String = ""
    @Published var bio: String = ""
    @Published var avatar = PlaceholderImage.avatar
    @Published var isShowPhotoPicker: Bool = false
    @Published var isLoading: Bool = false
    @Published var isCheckedIn: Bool = false
    @Published var alertItem: AlertItem?
    
    private var existingProfileRecord: CKRecord? {
        didSet { profileContext = .update }
    }
    
    var profileContext: ProfileContext = .create
    
    func isValidProfile() -> Bool {
        guard !firstName.isEmpty,
              !lastName.isEmpty,
              !companyName.isEmpty,
              !bio.isEmpty,
              avatar != PlaceholderImage.avatar,
              bio.count <= 100 else { return false }
        
        return true
    }
    
    func getCheckedInStatus() -> Void {
        guard let profileRecordID = CloudKitManager.shared.profileRecordID else { return }
        
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let record):
                    if let _ = record[DDGProfile.kIsCheckedIn] as? CKRecord.Reference {
                        self.isCheckedIn = true
                    } else {
                        self.isCheckedIn = false
                    }
                case .failure(_):
                    break
                }
            }
        }
    }
    
    func checkOut() -> Void {
        guard let profileID = CloudKitManager.shared.profileRecordID else {
            alertItem = AlertContext.unabelToGetProfile
            return
        }
        
        CloudKitManager.shared.fetchRecord(with: profileID) { result in
            switch result {
            case .success(let record):
                record[DDGProfile.kIsCheckedIn] = nil
                
                CloudKitManager.shared.save(record: record) { [self] result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(_):
                            isCheckedIn = false
                        case .failure(_):
                            alertItem = AlertContext.unableToCheckInOrOut
                        }
                    }
                }
            case .failure(_):
                DispatchQueue.main.async { self.alertItem = AlertContext.unableToCheckInOrOut }
            }
        }
    }
    
    func createProfile() -> Void {
        guard isValidProfile() else {
            alertItem = AlertContext.invalidProfile
            return
        }
        
        let profileRecord = createProfileRecord()
        
        guard let userRecord = CloudKitManager.shared.userRecprd else {
            alertItem = AlertContext.noUserRecord
            return
        }
        
        userRecord["userProfile"] = CKRecord.Reference(recordID: profileRecord.recordID, action: .none)
        
        showLoadingView()
        
        CloudKitManager.shared.batchSave(records: [userRecord, profileRecord]) { result in
            DispatchQueue.main.async { [self] in
                hideLoadingView()
                switch result {
                case .success(let records):
                    for record in records where record.recordType == RecordType.profile {
                        existingProfileRecord = record
                        CloudKitManager.shared.profileRecordID = record.recordID
                    }
                    alertItem = AlertContext.createProfileSuccess
                case .failure(_):
                    alertItem = AlertContext.createProfileFailure
                }
            }
        }
    }
    
    func getProfile() -> Void {
        
        guard let userRecord = CloudKitManager.shared.userRecprd else {
            alertItem = AlertContext.noUserRecord
            return
        }
        
        guard let profileReference = userRecord["userProfile"] as? CKRecord.Reference else { return }
        
        let profileRecordID = profileReference.recordID
        
        showLoadingView()
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { result in
            DispatchQueue.main.async { [self] in
                hideLoadingView()
                switch result {
                case .success(let record):
                    existingProfileRecord = record
                    let profile = DDGProfile(record: record)
                    firstName = profile.firstName
                    lastName = profile.lastName
                    companyName = profile.companyName
                    bio = profile.bio
                    avatar = profile.createAvatarImage()
                case .failure(_):
                    alertItem = AlertContext.unabelToGetProfile
                }
            }
        }
    }
    
    func updateProfile() -> Void {
        guard isValidProfile() else {
            alertItem = AlertContext.invalidProfile
            return
        }
        
        guard let profileRecord = existingProfileRecord else {
            alertItem = AlertContext.unabelToGetProfile
            return
        }
        
        profileRecord[DDGProfile.kFirstName] = firstName
        profileRecord[DDGProfile.kLastName] = lastName
        profileRecord[DDGProfile.kCompanyName] = companyName
        profileRecord[DDGProfile.kBio] = bio
        profileRecord[DDGProfile.kAvatar] = avatar.convertToCKAsset()
        
        showLoadingView()
        CloudKitManager.shared.save(record: profileRecord) { result in
            DispatchQueue.main.async { [self] in
                hideLoadingView()
                switch result {
                case .success(let success):
                    alertItem = AlertContext.updateProfileSuccess
                case .failure(let failure):
                    alertItem = AlertContext.updateProfileFailure
                }
            }
        }
    }
    
    private func createProfileRecord() -> CKRecord {
        let profileRecord = CKRecord(recordType: RecordType.profile)
        profileRecord[DDGProfile.kFirstName] = firstName
        profileRecord[DDGProfile.kLastName] = lastName
        profileRecord[DDGProfile.kCompanyName] = companyName
        profileRecord[DDGProfile.kBio] = bio
        profileRecord[DDGProfile.kAvatar] = avatar.convertToCKAsset()
        
        return profileRecord
    }
    
    private func showLoadingView() { isLoading = true }
    private func hideLoadingView() { isLoading = false }
}
