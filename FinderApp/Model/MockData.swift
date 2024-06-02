//
//  MockData.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 28.04.2024.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import CloudKit

struct MockData {
    static var location: CKRecord {
        let record                       = CKRecord(recordType: RecordType.location)
        record[DDGLocation.kName]        = "Musafer"
        record[DDGLocation.kAddress]     = "Mira 20"
        record[DDGLocation.kDescription] = "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable."
        record[DDGLocation.kWebsiteURL]  = "https://mustafos.github.io"
        record[DDGLocation.kLocation]    = CLLocation(latitude: 49.747438, longitude: 13.377562)
        record[DDGLocation.kPhoneNumber] = "377 560 789"
        
        return record
    }
    
    static var profile: CKRecord {
        let record                      = CKRecord(recordType: RecordType.profile)
        record[DDGProfile.kFirstName]   = "Test"
        record[DDGProfile.kLastName]    = "User"
        record[DDGProfile.kCompanyName] = "Best Company Ever"
        record[DDGProfile.kBio]         = "I am robot"
        
        return record
    }
}
