//
//  FavoriteWord.swift
//  VayDosh
//
//  Created by Adam Miziev on 8/25/24.
//

import SwiftUI

struct FavoriteWord: View {
    
    @ObservedObject var favoriteWord: Item
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    CustomText(text: "Dictionary:", size: 14,
                               color: .secondary)
                    CustomText(text: favoriteWord.dictionary!, size: 18,
                               weight: .light)
                }
                Spacer()
                FavoriteButton(isFavorite: $favoriteWord.isFavorite)
            }
            Divider()
            CustomText(text: "ING", size: 14,
                       weight: .black)
            if favoriteWord.dictionary! == "УЖА27"
                || favoriteWord.dictionary! == "ИТС33" {
                CustomText(text: "Latin | Cyrillic", size: 14,
                           color: .secondary)
            }
            CustomText(text: favoriteWord.ingush!, size: 18,
                       weight: .light)
            CustomText(text: "RU", size: 14,
                       weight: .black)
            CustomText(text: favoriteWord.russian!, size: 18,
                       weight: .light)
        }
        .padding()
        .background(Color.secondaryBG)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .frame(maxWidth: .infinity)
    }
}
