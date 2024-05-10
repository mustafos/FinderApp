//
//  AppTabView.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 21.05.2023.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import SwiftUI

struct AppTabView: View {
    var body: some View {
//        ZStack(alignment: .bottom) {
//            Color("brandSelego")
            LocationMapView()
//        }
//        TabView {
//            LocationMapView()
//                .tabItem {
//                    Label("Map", systemImage: "map")
//                }
//            LocationListView()
//                .tabItem {
//                    Label("Locations", systemImage: "building")
//                }
//            
//            NavigationView {
//                ProfileView()
//            }
//            .tabItem {
//                Label("Profile", systemImage: "person")
//            }
//        }
//        .accentColor(.brandPrimary)
    }
}

#Preview {
    AppTabView()
}
