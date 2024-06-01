//
//  ProfileModelView.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 01.06.2024.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import SwiftUI

struct ProfileModelView: View {
    var body: some View {
        ZStack {
            VStack {
                Spacer().frame(height: 60)
                Text("Mustafa Bekirov")
                    .bold()
                    .font(.title2)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                
                Text("Company")
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                    .foregroundColor(.secondary)
                
                Text("This is my sample bio. Let's keep typing to see how long we can make this, how does the padding look.")
                    .lineLimit(3)
                    .padding()
            }
            .frame(width: 300, height: 230)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(16)
            .overlay(Button {
                    // dismiss
                } label: {
                    XDismissButton()
                }, alignment: .topTrailing
            )
            
            Image(uiImage: PlaceholderImage.avatar)
                .resizable()
                .scaledToFill()
                .frame(width: 110, height: 110)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 6)
                .offset(y: -120)
        }
    }
}

#Preview {
    ProfileModelView()
}
