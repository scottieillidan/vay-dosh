//
//  CustomMenuButton.swift
//  VayDosh
//
//  Created by Adam Miziev on 8/31/24.
//

import SwiftUI

struct CustomMenuButton: View {
    var language: Language
    var flag: String
    var title: String
    var disabled: Bool = false
    var body: some View {
        Button {
            LocalizationService.shared.language = language
        } label: {
            CustomText(text: title)
            Image(flag)
        }
        .disabled(disabled)
    }
}
