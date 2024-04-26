//
//  LocationCell.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 26.04.2024.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import SwiftUI

struct LocationCell: View {
    
    var body: some View {
        HStack {
            Image("default-square-asset")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .padding(.vertical, 8)
            
            VStack(alignment: .leading) {
                Text("Test Location Name")
                    .americanFont(size: 21)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                
                HStack {
                    AvatarView(size: 35)
                    AvatarView(size: 35)
                    AvatarView(size: 35)
                    AvatarView(size: 35)
                    AvatarView(size: 35)
                }
            }
            .padding(.leading)
        }
    }
}

#Preview {
    LocationCell()
}
