//
//  TabBar.swift
//  LearnApp
//
//  Created by Mustafa Bekirov on 23.03.2023.
//

import SwiftUI

struct TabBar: View {
    @State var color: Color = .teal
    @State var selectedX: CGFloat = 0
    @State var x: [CGFloat] = [0, 0, 0, 0]
    
    var body: some View {
        GeometryReader { proxy in
            let hasHomeIndicator = proxy.safeAreaInsets.bottom > 0
            
            HStack {
                content
            }
            .padding(.bottom, hasHomeIndicator ? 16 : 0)
            .frame(maxWidth: .infinity, maxHeight: hasHomeIndicator ? 88 : 49)
            .background(.ultraThinMaterial)
            .background(
                Circle()
                    .fill(color)
                    .offset(x: selectedX, y: -10)
                    .frame(width: 88)
                    .frame(maxWidth: .infinity, alignment: .leading)
            )
            .overlay(
                Rectangle()
                    .frame(width: 28, height: 5)
                    .cornerRadius(3)
                    .frame(width: 88)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .offset(x: selectedX)
                    .blendMode(.overlay)
            )
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
        }
    }
    
    var content: some View {
        ForEach<[_], ID, Any>(Array(unsafeUninitializedCapacity: tabItems.enumerated()), id: \.offset) { index, tab in
            if index == 0 { Spacer() }
            
            Button {
                withAnimation(.tabSelection) {
                    selectedX = x[index]
                    color = tab.color
                }
            } label: {
                VStack(spacing: 0) {
                    Image(systemName: tab.icon)
                        .symbolVariant(.fill)
                        .font(.system(size: 17, weight: .bold))
                        .frame(width: 44, height: 29)
                    Text(tab.name).font(.caption2)
                        .frame(width: 88)
                        .lineLimit(1)
                }
            }
            .frame(width: 44)
            
            Spacer()
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
            .environmentObject(Model())
    }
}
