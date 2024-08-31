//
//  MainView.swift
//  VayDosh
//
//  Created by Adam Miziev on 8/24/24.
//

import SwiftUI

struct Mainview: View {
    
    @StateObject private var keyboardResponder = KeyboardResponder()
    
    @ObservedObject private var switchLang = SwitchLang()
    
    @State private var selectedTab = "Search"
    
    private var tabs: [String] = ["Search", "Favorites", "Menu"]
    
    private var icons: [String: String] = [
        "Search": "magnifyingglass",
        "Favorites": "star",
        "Menu": "list.bullet"
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .environmentObject(switchLang)
                    .tag(tabs[0])
                FavoriteWordsListView()
                    .tag(tabs[1])
                MenuView()
                    .tag(tabs[2])
            }
            if !keyboardResponder.isKeyboardVisible {
                HStack {
                    ForEach(tabs, id: \.self) { tab in
                        Spacer()
                        TabBarItem(selectedTab: $selectedTab,
                                   icon: icons[tab]!, title: tab)
                        Spacer()
                    }
                }
                .padding(.vertical, 5)
                .background(.background)
            }
        }
    }
}
