//
//  CKRecord+Extension.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 01.05.2024.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import CloudKit

extension CKRecord {
    func convertToDDGLocation() -> DDGLocation { return DDGLocation(record: self) }
    func convertToDDGProfile() -> DDGProfile { return DDGProfile(record: self) }
}
