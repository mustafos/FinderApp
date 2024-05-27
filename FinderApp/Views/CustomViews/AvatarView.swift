//
//  AvatarView.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 26.04.2024.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import SwiftUI

struct AvatarView: View {
    
    var image: UIImage
    var size: CGFloat
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .clipShape(Circle())
    }
}

#Preview {
    AvatarView(image: PlaceholderImage.avatar, size: 24)
}
