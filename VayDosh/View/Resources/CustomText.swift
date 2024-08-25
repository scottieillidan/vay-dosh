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
    var body: some View {
        Text("Hello, World!".localized(language))
    }
}

#Preview {
    CustomText()
}
