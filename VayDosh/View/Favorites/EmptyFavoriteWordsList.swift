//
//  EmptyFavoritesList.swift
//  VayDosh
//
//  Created by Adam Miziev on 8/25/24.
//

import SwiftUI

struct EmptyFavoriteWordsList: View {
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                LottieView(loopMode: .playOnce, animationName: "gold-star")
                    .frame(width: 150, height: 150)
                LottieView(loopMode: .loop, animationName: "shining-stars")
                    .frame(height: 150)
            }
            CustomText(text: "No Favorites yet", size: 30,
                       weight: .bold, textAlignment: .center)
            HStack {
                CustomText(text: "Add words using", size: 18,
                           color: .secondary, textAlignment: .center)
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
            Spacer()
        }
        .padding()
    }
}
