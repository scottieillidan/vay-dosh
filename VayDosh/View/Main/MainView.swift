//
//  MainView.swift
//  VayDosh
//
//  Created by Adam Miziev on 8/24/24.
//

import SwiftUI

struct Mainview: View {
    @StateObject private var model = AppIconModel()
    
    @StateObject private var keyboardResponder = KeyboardResponder()
    
    @State private var selectedTab = "Search"
    
    @AppStorage("language") private var language =
    LocalizationService.shared.language
    
    @ObservedObject private var buttonSwitch = SwitchLangModel()
    
    private var tabs: [String] = ["Search", "Favorites", "Menu"]
    
    private var icons: [String: String] = [
        "Search": "magnifyingglass",
        "Favorites": "star",
        "Menu": "list.bullet"
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                Home()
                    .environmentObject(buttonSwitch)
                    .tag(tabs[0])
                FavoriteListView()
                    .tag(tabs[1])
                MenuView()
                    .environmentObject(model)
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
                .background(.whiteBlack)
            }
        }
    }
}
