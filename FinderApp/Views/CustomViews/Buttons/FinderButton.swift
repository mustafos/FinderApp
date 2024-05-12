//
//  FinderButton.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 26.04.2024.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import SwiftUI

struct FinderButton: View {
    
    var title: String
    
    var body: some View {
        Text(title)
            .americanFont(size: 20)
            .frame(width: 280, height: 44)
            .background(Color.brandPrimary)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}

#Preview {
    FinderButton(title: "Create Profile")
}
