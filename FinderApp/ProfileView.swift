//
//  ProfileView.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 21.05.2023.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import SwiftUI
//    .font(.custom("AmericanTypewriter", size: 21, relativeTo: .title))
struct ProfileView: View {
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var companyName: String = ""
    @State private var bio: String = ""
    
    var body: some View {
        VStack {
            ZStack {
                Color(.secondarySystemBackground)
                    .frame(height: 130)
                    .cornerRadius(12)
                    .padding(.horizontal)
                
                HStack(spacing: 16) {
                    ZStack {
                        AvatarView(size: 84)
                        
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14, height: 14)
                            .foregroundColor(.white)
                            .offset(y: 30)
                    }
                    .padding(.leading, 12)
                    
                    VStack(spacing: 1) {
                        TextField("First Name", text: $firstName)
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                        
                        TextField("Last Name", text: $lastName)
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                        TextField("Company Name", text: $companyName)
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                    }
                    .padding(.trailing, 16)
                }
                .padding()
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Bio:")
                    .font(.callout)
                    .foregroundColor(.secondary)
                +
                Text(" \(100 - bio.count) ")
                    .bold()
                    .font(.callout)
                    .foregroundColor(bio.count <= 100 ? .brandPrimary : .red)
                +
                Text("Characters Remain")
                    .font(.callout)
                    .foregroundColor(.secondary)
                
                TextEditor(text: $bio)
                    .frame(height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.secondary, lineWidth: 1))
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            Button {
                // action
            } label: {
                Text("Create Profile")
                    .bold()
                    .frame(width: 280, height: 44)
                    .background(Color.brandPrimary)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .navigationTitle("Profile")
    }
}

#Preview {
    NavigationView {
        ProfileView()
    }
}
