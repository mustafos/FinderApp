//
//  CustomModifiers.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 26.04.2024.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import SwiftUI

struct ProfileNameText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("AmericanTypewriter-Bold", size: 32))
            .lineLimit(1)
            .minimumScaleFactor(0.75)
    }
}
