//
//  MenuView.swift
//  VayDosh
//
//  Created by Adam Miziev on 5/5/23.
//

import SwiftUI

struct MenuView: View {
    @AppStorage("displayMode") private var displayMode = DisplayMode.system
    @AppStorage("language") private var language =
    LocalizationService.shared.language
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink(destination: VocabularyView()) {
                        CustomText(text: "Composition", size: 17)
                    }
                } header: {
                    SectionHeaderView(icon: "books.vertical", section: "VayDosh")
                }
                AppearanceSectionView(displayMode: $displayMode)
                CustomLinkView(url: "https://t.me/adammiziev", title: "Support")
                Section {
                    NavigationLink(destination: InfoView()) {
                        HStack{
                            Image(systemName: "info.circle")
                                .resizable()
                                .frame(width: 20, height: 20)
                            CustomText(text: "About", size: 17)
                        }
                    }
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    CustomNavigationTitle(title: "Menu")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        CustomText(text: "VayDosh Interface Language:")
                        CustomMenuButton(language: .ingush, flag: "INH",
                                         title: "Soon", disabled: true)
                        CustomMenuButton(language: .russian, flag: "RU",
                                         title: "Russian")
                        CustomMenuButton(language: .english_us, flag: "US",
                                         title: "English (US)")
                    } label: {
                        Spacer()
                        Image(language.userSymbol.uppercased())
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 30, height: 30)
                            .shadow(radius: 3, x: 3, y: 3)
                    }
                    .padding(.trailing, 10)
                    .padding(.bottom, 10)
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
