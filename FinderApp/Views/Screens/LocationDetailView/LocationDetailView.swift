//
//  LocationDetailView.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 22.04.2023.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import SwiftUI

struct LocationDetailView: View {
    
    @ObservedObject var viewModel: LocationDetailViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                BannerImageView(image: viewModel.location.createBannerImage())
                
                HStack {
                    AddressView(address: viewModel.location.address)
                    Spacer()
                }.padding(.horizontal)
                
                DescriptionView(description: viewModel.location.description)
                
                ZStack {
                    Capsule()
                        .frame(height: 80)
                        .foregroundColor(Color(.secondarySystemBackground))
                    
                    HStack(spacing: 20) {
                        Button {
                            viewModel.getDirectionstoLocation()
                        } label: {
                            LocationActionButton(color: .brandPrimary, imageName: "location.fill")
                        }
                        
                        Link(destination: URL(string: viewModel.location.websiteURL)!, label: {
                            LocationActionButton(color: .brandPrimary, imageName: "network")
                        })
                        
                        Button {
                            viewModel.callLocation()
                        } label: {
                            LocationActionButton(color: .brandPrimary, imageName: "phone.fill")
                        }
                        
                        Button {
                            viewModel.updateCheckInStatus(to: viewModel.isCheckedIn ? .checkedOut : .checedIn)
                        } label: {
                            LocationActionButton(color: .brandPrimary, imageName: "person.fill.checkmark")
                        }
                    }
                }.padding(.horizontal)
                
                Text("Who's Here?").americanFont(size: 20)
                
                ScrollView {
                    LazyVGrid(columns: viewModel.columns, content: {
                        ForEach(viewModel.checkedInProfiles) { profile in
                            FirstNameAvatarView(profile: profile)
                                .onTapGesture {
                                    viewModel.isShowingProfileModel = true
                                }
                        }
                    })
                }
                Spacer()
            }
            
            if viewModel.isShowingProfileModel {
                Color(.systemBackground)
                    .ignoresSafeArea()
                    .opacity(0.9)
                //                    .transition(.opacity)
                    .transition(AnyTransition.opacity.animation(.easeOut(duration: 0.35)))
                    .zIndex(1)
                
                ProfileModelView(isShowingProfileModel: $viewModel.isShowingProfileModel, profile: DDGProfile(record: MockData.profile))
                    .transition(.opacity.combined(with: .slide))
                    .animation(.easeOut)
                    .zIndex(2)
            }
        }
        .onAppear { viewModel.getCheckedInProfiles() }
        .alert(item: $viewModel.alertItem, content: { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        })
        .navigationTitle(viewModel.location.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        LocationDetailView(viewModel: LocationDetailViewModel(location: DDGLocation(record: MockData.location)))
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
    
    var profile: DDGProfile
    
    var body: some View {
        VStack {
            AvatarView(image: profile.createAvatarImage(), size: 64)
            
            Text(profile.firstName)
                .americanFont(size: 18)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
    }
}

struct BannerImageView: View {
    
    var image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(height: 120)
    }
}

struct AddressView: View {
    
    var address: String
    
    var body: some View {
        Label(address, systemImage: "mappin.and.ellipse")
            .font(.custom("AmericanTypewriter", size: 12, relativeTo: .caption))
            .foregroundColor(.secondary)
    }
}

struct DescriptionView: View {
    
    var description: String
    
    var body: some View {
        Text(description)
            .americanFont(size: 18, bold: false)
            .lineLimit(3)
            .minimumScaleFactor(0.75)
            .frame(height: 70)
            .padding(.horizontal)
    }
}
