//
//  DiceButton.swift
//  VayDosh
//
//  Created by Adam Miziev on 8/31/24.
//

import SwiftUI

struct DiceButton: View {
    @Binding var isShowTranslate: Bool
    @Binding var randomWord: Item?
    var randomWords: FetchedResults<Item>
    var body: some View {
        HStack {
            Spacer()
            Button {
                withAnimation {
                    randomWord =
                    randomWords.randomElement()
                    
                    if isShowTranslate {
                        isShowTranslate.toggle()
                    }
                    
                    UIImpactFeedbackGenerator(style:
                            .soft).impactOccurred()
                }
            } label: {
                Image(systemName: "dice")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35)
            }
        }
    }
}
