//
//  ProfileView.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 21.05.2023.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import SwiftUI

struct ProfileView: View {
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var companyName: String = ""
    @State private var bio: String = ""
    @State private var avatar = PlaceholderImage.avatar
    @State private var isShowPhotoPicker: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                NameBackgroundView()
                
                HStack(spacing: 16) {
                    ZStack {
                        AvatarView(image: avatar, size: 84)
                        EditImage()
                    }
                    .padding(.leading, 12)
                    .onTapGesture { isShowPhotoPicker = true }
                    
                    VStack(spacing: 1) {
                        TextField("First Name", text: $firstName)
                            .profileNameStyle()
                        
                        TextField("Last Name", text: $lastName)
                            .profileNameStyle()
                        
                        TextField("Company Name", text: $companyName)
                            .font(.custom("AmericanTypewriter", size: 18))
                    }.padding(.trailing, 16)
                }.padding()
            }
            
            VStack(alignment: .leading, spacing: 6) {
                CharacterRemainView(currentCount: bio.count)
                TextEditor(text: $bio)
                    .frame(height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.secondary, lineWidth: 1))
            }.padding(.horizontal, 20)
            
            Spacer()
            
            Button {} label: {
                FinderButton(title: "Create Profile")
            }
        }
        .navigationTitle("Profile")
        .sheet(isPresented: $isShowPhotoPicker) {
            PhotoPicker(image: $avatar)
        }
    }
}

#Preview {
    NavigationView {
        ProfileView()
    }
}

struct NameBackgroundView: View {
    var body: some View {
        Color(.secondarySystemBackground)
            .frame(height: 130)
            .cornerRadius(12)
            .padding(.horizontal)
    }
}

struct EditImage: View {
    var body: some View {
        Image(systemName: "square.and.pencil")
            .resizable()
            .scaledToFit()
            .frame(width: 14, height: 14)
            .foregroundColor(.white)
            .offset(y: 30)
    }
}

struct CharacterRemainView: View {
    
    var currentCount: Int
    
    var body: some View {
        Text("Bio:")
            .font(.custom("AmericanTypewriter", size: 20, relativeTo: .callout))
            .foregroundColor(.secondary)
        +
        Text(" \(100 - currentCount) ")
            .font(.custom("AmericanTypewriter-Bold", size: 20, relativeTo: .callout))
            .foregroundColor(currentCount <= 100 ? .brandPrimary : .grubRed)
        +
        Text("Characters Remain")
            .font(.custom("AmericanTypewriter", size: 20, relativeTo: .callout))
            .foregroundColor(.secondary)
    }
}
