//
//  Text+Extension.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 24.04.2024.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import Foundation
import SwiftUI

typealias TextExtension = Text

extension TextExtension {
    func americanFont(size: CGFloat, bold: Bool = true) -> some View {
        return self
            .font(.custom("AmericanTypewriter\(bold ? "-Bold" : "")", size: size))
    }
}
