//
//  AlphabetView.swift
//  VayDosh
//
//  Created by Adam Miziev on 8/26/24.
//

import SwiftUI

struct AlphabetView: View {
    let alphabet: [(character: String, transcription: String)]
    let columns = Array(repeating: GridItem(.flexible()), count: 6)
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(alphabet.indices, id: \.self) { letter in
                AlphabetGridItem(character: alphabet[letter].character,
                                 transcription: alphabet[letter].transcription)
            }
        }
        .padding(15)
        .background(Color.secondaryBG)
        .clipShape(.rect(cornerRadius: 35))
    }
}
