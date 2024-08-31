//
//  DetailView.swift
//  VayDosh
//
//  Created by Adam Miziev on 5/2/23.
//

import SwiftUI

struct DetailView: View {
    
    @AppStorage("language") private var language =
    LocalizationService.shared.language
    
    @State var shareText: ShareText?
    @State var isPresented = false
    
    @ObservedObject var word: Item
    
    @EnvironmentObject var switchLang: SwitchLang
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 5) {
                Button {
                    isPresented.toggle()
                } label: {
                    CustomText(text: "Dictionary:".localized(language)
                               + " \(word.dictionary!)", size: 30,
                               weight: .bold, color: .accentColor)
                }
                .sheet(isPresented: $isPresented,
                       content: { VocabularyView() })
                CustomText(text: switchLang.switchLang ?
                           "RU" : "ING", size: 14,
                           weight: .black)
                CustomText(text: switchLang.switchLang ?
                           word.russian! : word.ingush!,
                           size: 17)
                Divider()
                CustomText(text: switchLang.switchLang ?
                           "ING" : "RU", size: 14,
                           weight: .black)
                CustomText(text: switchLang.switchLang ?
                           word.ingush! : word.russian!,
                           size: 17)
                Spacer()
                IngushAlphabetView()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(alignment: .bottom, spacing: 5) {
                        ShareButton(shareText: $shareText,
                                    text: "(VayDosh)".localized(language) +
                                    "\n" + "ING: ".localized(language) +
                                    word.ingush! + "\n" +
                                    "RU: ".localized(language) +
                                    word.russian!)
                        FavoriteButton(isFavorite: $word.isFavorite)
                    }
                }
            }
        }
    }
}
