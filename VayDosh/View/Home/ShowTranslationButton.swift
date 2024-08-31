//
//  ShowTranslationButton.swift
//  VayDosh
//
//  Created by Adam Miziev on 8/31/24.
//

import SwiftUI

struct ShowTranslationButton: View {
    @Binding var isShowTranslate: Bool
    var word: String?
    var body: some View {
        ZStack {
            Button {
                withAnimation {
                    isShowTranslate.toggle()
                }
            } label: {
                CustomText(text: "Show translate", size: 17, weight: .bold)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 60)
                    .background(Color.accentColor)
                    .clipShape(.capsule)
                
            }
            .opacity(isShowTranslate ? 0 : 1)
            CustomText(text: word ?? "Welcome!", size: 20, weight: .light)
            .opacity(isShowTranslate ? 1 : 0)
        }
    }
}
