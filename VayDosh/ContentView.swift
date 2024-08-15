//
//  ContentView.swift
//  VayDosh
//
//  Created by Adam Miziev on 5/2/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model = AppIconModel()
    
    @State private var selectedTab = 0
    
    @State var showDetail = false
    
    @AppStorage("language") private var language = 
    LocalizationService.shared.language
    
    @ObservedObject var buttonSwitch = SwitchLangModel()
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                Home()
                    .environmentObject(buttonSwitch)
                    .tabItem{
                        VStack {
                            Image(systemName: "magnifyingglass")
                            Text("Search".localized(language))
                        }
                    }
                    .tag(0)
//                FavoriteListView()
//                    .tabItem{
//                        VStack {
//                            Image(systemName: "star")
//                            Text("Favorites".localized(language))
//                        }
//                    }
//                    .tag(1)
                MenuView()
                    .environmentObject(model)
                    .tabItem{
                        VStack {
                            Image(systemName: "list.bullet")
                            Text("Menu".localized(language))
                        }
                    }
                    .tag(2)
            }
            .onAppear {
                // Correct the transparency bug for Tab bars
                let tabBarAppearance = UITabBarAppearance()
                tabBarAppearance.configureWithOpaqueBackground()
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                // Correct the transparency bug for Navigation bars
                let navigationBarAppearance = UINavigationBarAppearance()
                navigationBarAppearance.configureWithOpaqueBackground()
                UINavigationBar.appearance().scrollEdgeAppearance = 
                navigationBarAppearance
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
