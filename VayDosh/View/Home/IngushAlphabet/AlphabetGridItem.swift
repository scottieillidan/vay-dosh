//
//  AlphabetGridItem.swift
//  VayDosh
//
//  Created by Adam Miziev on 8/26/24.
//

import SwiftUI

struct AlphabetGridItem: View {
    var character: String
    var transcription: String
    var body: some View {
        VStack(spacing: 10) {
            CustomText(text: character,
                       size: 30, weight: .bold)
                .lineLimit(1)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            CustomText(text: transcription, size: 14)
                .lineLimit(1)
        }
        .padding(5)
        .background()
        .clipShape(.rect(cornerRadius: 20))
    }
}
