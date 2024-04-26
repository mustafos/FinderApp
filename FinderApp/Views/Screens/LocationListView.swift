//
//  LocationListView.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 21.05.2023.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import SwiftUI

struct LocationListView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<10) { item in
                    NavigationLink {
                        LocationDetailView()
                    } label: {
                        LocationCell()
                    }
                }
            }.navigationTitle("Finder Spots")
        }
    }
}

#Preview {
    LocationListView()
}
