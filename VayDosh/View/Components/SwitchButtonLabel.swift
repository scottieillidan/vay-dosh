//
//  SwitchButtonLabel.swift
//  VayDosh
//
//  Created by Adam Miziev on 8/31/24.
//

import SwiftUI

struct SwitchButtonLabel: View {
    @Binding var switchLang: Bool
    var body: some View {
        let whichLang = switchLang ? (from: "RU", to: "ING", img: "RUING", fromColor: Color.switchButtonRed, toColor: Color.accentColor) : (from: "ING", to: "RU", img: "INGRU", fromColor: Color.accentColor, toColor: Color.switchButtonRed)
        HStack {
            CustomText(text: whichLang.from, size: 14, weight: .bold, color: whichLang.fromColor)
                .frame(width: 40)
            Image(whichLang.img)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 35, height: 35)
            CustomText(text: whichLang.to, size: 14, weight: .bold, color: whichLang.toColor)
                .frame(width: 40)
        }
        .padding(.trailing, 10)
    }
}
