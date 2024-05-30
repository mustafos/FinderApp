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
                        
                    } label: {
                        LocationActionButton(color: .red, imageName: "person.fill.checkmark")
                    }
                }
            }.padding(.horizontal)
            
            Text("Who's Here?").americanFont(size: 20)
            
            ScrollView {
                LazyVGrid(columns: viewModel.columns, content: {
                    FirstNameAvatarView(image: PlaceholderImage.avatar, firstName: "Mustafa")
                    FirstNameAvatarView(image: PlaceholderImage.avatar, firstName: "Kelly")
                    FirstNameAvatarView(image: PlaceholderImage.avatar, firstName: "Arnold")
                    FirstNameAvatarView(image: PlaceholderImage.avatar, firstName: "Sean")
                    FirstNameAvatarView(image: PlaceholderImage.avatar, firstName: "Jack")
                    FirstNameAvatarView(image: PlaceholderImage.avatar, firstName: "Brian")
                    FirstNameAvatarView(image: PlaceholderImage.avatar, firstName: "Smit")
                })
            }
            Spacer()
        }
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
    var image: UIImage
    var firstName: String
    var body: some View {
        VStack {
            AvatarView(image: image, size: 64)
            
            Text(firstName)
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
