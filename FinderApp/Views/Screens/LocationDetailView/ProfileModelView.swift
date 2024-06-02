//
//  ProfileModelView.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 01.06.2024.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import SwiftUI

struct ProfileModelView: View {
    
    @Binding var isShowingProfileModel: Bool
    var profile: DDGProfile
    
    var body: some View {
        ZStack {
            VStack {
                Spacer().frame(height: 60)
                Text(profile.firstName + " " + profile.lastName)
                    .bold()
                    .font(.title2)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                
                Text(profile.companyName)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                    .foregroundColor(.secondary)
                
                Text(profile.bio)
                    .lineLimit(3)
                    .padding()
            }
            .frame(width: 300, height: 230)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(16)
            .overlay(Button {
                withAnimation { isShowingProfileModel = false }
            } label: {
                XDismissButton()
            }, alignment: .topTrailing)
            
            Image(uiImage: profile.createAvatarImage())
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
    ProfileModelView(isShowingProfileModel: .constant(true),
                     profile: DDGProfile(record: MockData.profile))
}
