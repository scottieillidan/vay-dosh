//
//  TabBarItem.swift
//  VayDosh
//
//  Created by Adam Miziev on 8/24/24.
//

import SwiftUI

struct TabBarItem: View {
    
    @Binding var selectedTab: String
    
    var icon: String
    var title: String
    
    var body: some View {
        Button(action: {
            withAnimation(.spring) {
                selectedTab = title
            }
        }, label: {
            HStack {
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                if(selectedTab == title) {
                    CustomText(text: title, size: 14, weight: .medium)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(selectedTab == title ? Color.accent : .clear)
            .clipShape(.capsule)
        })
        .foregroundStyle(.primary)
        .disabled(selectedTab == title)
    }
}
