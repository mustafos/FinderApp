//
//  AlertItem.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 04.05.2024.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    //MARK: – MapView Errors
    static let unableToGetLocations = AlertItem(title: Text("Locations Error"),
                                                message: Text("Unable to retrive locations at this time.\nPlease try again."),
                                                dismissButton: .default(Text("OK")))
}
