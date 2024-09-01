//
//  CustomText.swift
//  VayDosh
//
//  Created by Adam Miziev on 8/24/24.
//

import SwiftUI

struct CustomText: View {
    
    @AppStorage("language") private var language =
    LocalizationService.shared.language
    
    var text: String
    var font: String = "Open Sans"
    var size: Double = 12
    var weight: Font.Weight = .regular
    var color: Color = .primary
    var textAlignment: TextAlignment = .leading
    
    var body: some View {
        Text(text.localized(language))
            .font(.custom(font, size: size))
            .fontWeight(weight)
            .foregroundStyle(color)
            .multilineTextAlignment(textAlignment)
    }
}
