//
//  ProfileView.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 21.05.2023.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import SwiftUI
import CloudKit

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    NameBackgroundView()
                    
                    HStack(spacing: 16) {
                        ZStack {
                            AvatarView(image: viewModel.avatar, size: 84)
                            EditImage()
                        }
                        .padding(.leading, 12)
                        .onTapGesture { viewModel.isShowPhotoPicker.toggle() }
                        
                        VStack(spacing: 1) {
                            TextField("First Name", text: $viewModel.firstName).profileNameStyle()
                            TextField("Last Name", text: $viewModel.lastName).profileNameStyle()
                            TextField("Company Name", text: $viewModel.companyName)
                                .font(.custom("AmericanTypewriter", size: 18))
                        }.padding(.trailing, 16)
                    }.padding()
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    CharacterRemainView(currentCount: viewModel.bio.count)
                    
                    TextEditor(text: $viewModel.bio)
                        .frame(height: 100)
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.secondary, lineWidth: 1))
                }.padding(.horizontal, 20)
                
                Spacer()
                
                Button {
                    viewModel.createProfile()
                } label: {
                    FinderButton(title: "Create Profile")
                }
                .padding(.bottom)
            }
            
            if viewModel.isLoading { LoadingView() }
        }
        .navigationTitle("Profile")
        .toolbar {
            Button {
                dismissKeyboard()
            } label: {
                Image(systemName: "keyboard.chevron.compact.down")
            }
        }
        .onAppear { viewModel.getProfile() }
        .alert(item: $viewModel.alertItem, content: { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        })
        .sheet(isPresented: $viewModel.isShowPhotoPicker) {
            PhotoPicker(image: $viewModel.avatar)
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
