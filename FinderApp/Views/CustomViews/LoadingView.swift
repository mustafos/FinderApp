//
//  LoadingView.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 20.05.2024.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .opacity(0.9)
                .ignoresSafeArea()
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .brandPrimary))
                .scaleEffect(2)
                .offset(y: -40)
        }
    }
}

#Preview {
    LoadingView()
}
