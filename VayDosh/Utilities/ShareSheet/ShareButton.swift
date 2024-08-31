//
//  ShareButton.swift
//  VayDosh
//
//  Created by Adam Miziev on 8/26/24.
//

import SwiftUI

struct ShareButton: View {
    @AppStorage("language") private var language =
    LocalizationService.shared.language
    @Binding var shareText: ShareText?
    var text: String
    var body: some View {
        Button {
            shareText = ShareText(text: text.localized(language))
        } label: {
            Image(systemName: "square.and.arrow.up")
        }
        .sheet(item: $shareText) { shareText in
            ShareSheet(text: shareText.text)
        }
    }
}
