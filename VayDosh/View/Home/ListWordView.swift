//
//  ListItemView.swift
//  VayDosh
//
//  Created by Adam Miziev on 5/2/23.
//

import SwiftUI

struct ListWordView: View {
    
    @ObservedObject var word: Item
    
    @EnvironmentObject var switchLang: SwitchLang
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5){
                CustomText(text: word.dictionary!,
                           size: 14, color: .secondary)
                CustomText(text: switchLang.switchLang ?
                           word.russian! : word.ingush!,
                           size: 17, weight: .medium)
                CustomText(text: switchLang.switchLang ?
                           word.ingush! : word.russian!, size: 15)
            }
            Spacer()
            if word.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(Color.yellow)
            }
        }
    }
}
