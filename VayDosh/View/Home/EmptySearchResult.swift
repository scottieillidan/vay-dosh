//
//  EmptySearchResult.swift
//  VayDosh
//
//  Created by Adam Miziev on 8/31/24.
//

import SwiftUI

struct EmptySearchResult: View {
    @Binding var searchText:  String
    var body: some View {
        VStack {
            LottieView(loopMode: .loop,
                       animationName: "empty")
            .frame(width: 150, height: 100)
            .scaleEffect(0.4)
            .padding(.vertical)
            CustomText(text: "No Results", size: 24,
                       weight: .bold, textAlignment: .center)
            CustomText(text: "There were no results for",
                       size: 20, textAlignment: .center)
            CustomText(text: "\"\(searchText)\".",
                       size: 20, textAlignment: .center)
            CustomText(text: "Try a new search.",
                       size: 20, textAlignment: .center)
        }
        .padding()
    }
}
