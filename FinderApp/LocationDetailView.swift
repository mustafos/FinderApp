//
//  LocationDetailView.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 22.04.2023.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import SwiftUI

struct LocationDetailView: View {
    
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]
    var body: some View {
        VStack(spacing: 16) {
            Image("default-banner-asset")
                .resizable()
                .scaledToFill()
                .frame(height: 120)
            
            HStack {
                Label("123 Main Screen", systemImage: "mappin.and.ellipse")
                    .font(.custom("AmericanTypewriter", size: 12, relativeTo: .caption))
                    .foregroundColor(.secondary)
                
                Spacer()
            }
            .padding(.horizontal)
            
            Text("There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable.")
                .americanFont(size: 18, bold: false)
                .lineLimit(3)
                .minimumScaleFactor(0.75)
                .frame(height: 70)
                .padding(.horizontal)
            
            ZStack {
                Capsule()
                    .frame(height: 80)
                    .foregroundColor(Color(.secondarySystemBackground))
                
                HStack(spacing: 20) {
                    Button {
                        
                    } label: {
                        LocationActionButton(color: .brandPrimary, imageName: "location.fill")
                    }
                    
                    Link(destination: URL(string: "https://www.apple.com")!, label: {
                        LocationActionButton(color: .brandPrimary, imageName: "network")
                    })
                    
                    Button {
                        
                    } label: {
                        LocationActionButton(color: .brandPrimary, imageName: "phone.fill")
                    }
                    
                    Button {
                        
                    } label: {
                        LocationActionButton(color: .red, imageName: "person.fill.checkmark")
                    }
                }
            }
            .padding(.horizontal)
            
            Text("Who's Here?")
                .americanFont(size: 20)
            
            ScrollView {
                LazyVGrid(columns: columns, content: {
                    FirstNameAvatarView(firstName: "Mustafa")
                    FirstNameAvatarView(firstName: "Kelly")
                    FirstNameAvatarView(firstName: "Arnold")
                    FirstNameAvatarView(firstName: "Sean")
                    FirstNameAvatarView(firstName: "Jack")
                    FirstNameAvatarView(firstName: "Brian")
                    FirstNameAvatarView(firstName: "Smit")
                })
            }
            Spacer()
        }
        .navigationTitle("Location Name")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        LocationDetailView()
    }
}

struct LocationActionButton: View {
    
    var color: Color
    var imageName: String
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(color)
                .frame(width: 60, height: 60)
            
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .frame(width: 22, height: 22)
        }
    }
}

struct FirstNameAvatarView: View {
    var firstName: String
    var body: some View {
        VStack {
            AvatarView(size: 64)
            
            Text(firstName)
                .americanFont(size: 18)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
    }
}
