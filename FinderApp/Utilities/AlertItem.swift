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
    // MARK: – MapView Errors
    static let unableToGetLocations = AlertItem(title: Text("Locations Error"),
                                                message: Text("Unable to retrive locations at this time.\nPlease try again."),
                                                dismissButton: .default(Text("OK")))
    
    static let locationRestricted = AlertItem(title: Text("Locations Restricted"),
                                              message: Text("Your location is restricted. This may be due to perental controls."),
                                              dismissButton: .default(Text("OK")))
    
    static let locationDenied = AlertItem(title: Text("Locations Denied"),
                                          message: Text("FinderApp does not have permission to access your location. To change that go to your phone's Settings > FinderApp > Location"),
                                          dismissButton: .default(Text("OK")))
    
    static let locationDisabled = AlertItem(title: Text("Locations Service Disabled"),
                                            message: Text("FinderApp does not have permission to access your location. To change that go to your phone's Settings > Privacy > Location Services"),
                                            dismissButton: .default(Text("OK")))
    
    // MARK: – ProfileView Errors
    static let invalidProfile = AlertItem(title: Text("Invalid Profile"),
                                          message: Text("All fields are required as well as a profile photo. Your bio must be < 100 characters.\nPlease try again."),
                                          dismissButton: .default(Text("OK")))
    
    static let noUserRecord = AlertItem(title: Text("No user Record"),
                                        message: Text("You must log into iCloud on your phone in order to utilize FinderApp's Profile.\nPlease log in on your phone's settings screen."),
                                        dismissButton: .default(Text("OK")))
    
    static let createProfileSuccess = AlertItem(title: Text("Profile Created Successfully."),
                                                message: Text("Your profile has successfully been created."),
                                                dismissButton: .default(Text("OK")))
    
    static let createProfileFailure = AlertItem(title: Text("Failed to Create Profile"),
                                                message: Text("We were unable to create your profile at this time.\nPlease check your internet connection and try again later of contact customer support if this persists."),
                                                dismissButton: .default(Text("OK")))
    
    static let unabelToGetProfile = AlertItem(title: Text("Unable to Retrieve Profile"),
                                              message: Text("We were unable to retrieve your profile at this time.\nPlease try again later of contact customer support if this persists."),
                                              dismissButton: .default(Text("OK")))
    
    static let updateProfileSuccess = AlertItem(title: Text("Profile Update Success!"),
                                              message: Text("Your Finder profile was updated successfully"),
                                              dismissButton: .default(Text("Sweet!")))
    
    static let updateProfileFailure = AlertItem(title: Text("Profile Update Faild!"),
                                              message: Text("We were unable to update your profile at this moment. \nPlease try again later."),
                                              dismissButton: .default(Text("Sweet!")))
    
    //MARK: – LocationDetailView Errors
    static let invalidePhoneNumber = AlertItem(title: Text("Invalide Profile Number"),
                                              message: Text("The phone number for the location is invalid. Please look up the phone number yourself."),
                                              dismissButton: .default(Text("OK")))
}
