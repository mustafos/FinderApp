//
//  DDGProfile.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 28.04.2024.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import CloudKit

struct DDGProfile {
    static let kFirstName   = "firstName"
    static let kLastName    = "lastName"
    static let kAvatar      = "avatar"
    static let kCompanyName = "companyName"
    static let kBio         = "bio"
    static let kIsCheckedIn = "isChackedIn"
    
    let ckRecordID: CKRecord.ID
    let firstName: String
    let lastName: String
    let avatar: CKAsset!
    let companyName: String
    let bio: String
    let isChackedIn: CKRecord.Reference? = nil
    
    init(record: CKRecord) {
        ckRecordID  = record.recordID
        firstName   = record[DDGProfile.kFirstName] as? String ?? "N/A"
        lastName    = record[DDGProfile.kLastName] as? String ?? "N/A"
        avatar      = record[DDGProfile.kAvatar] as? CKAsset
        companyName = record[DDGProfile.kCompanyName] as? String ?? "N/A"
        bio         = record[DDGProfile.kBio] as? String ?? "N/A"
    }
}
