//
//  TabBarItem.swift
//  VayDosh
//
//  Created by Adam Miziev on 8/24/24.
//

import SwiftUI

struct TabBarItem: View {
    @AppStorage("language") private var language =
    LocalizationService.shared.language
    
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
                    .foregroundStyle(.BW)
                if(selectedTab == title) {
                    Text(title.localized(language))
                        .font(.footnote)
                        .foregroundStyle(.BW)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(selectedTab == title ? .accent : .clear)
            .clipShape(.capsule)
        })
        .disabled(selectedTab == title)
        
    }
}
