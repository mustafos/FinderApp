//
//  LocationManager.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 08.05.2024.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import Foundation

final class LocationManager: ObservableObject {
    @Published var locations: [DDGLocation] = []
}
