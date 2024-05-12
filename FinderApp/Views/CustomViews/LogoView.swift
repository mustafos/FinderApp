//
//  LogoView.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 12.05.2024.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import SwiftUI

struct LogoView: View {
    
    var frameWidth: CGFloat
    
    var body: some View {
        Image("ddg-map-logo")
            .resizable()
            .scaledToFit()
            .frame(height: frameWidth)
    }
}
