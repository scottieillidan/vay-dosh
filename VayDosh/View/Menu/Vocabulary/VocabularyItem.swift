//
//  VocabularyItem.swift
//  VayDosh
//
//  Created by Adam Miziev on 8/26/24.
//

import SwiftUI

struct VocabularyItem: View {
    var code: String
    var description: String
    
    var body: some View {
        HStack {
            CustomText(text: code, size: 13, color: .accentColor)
                .frame(width: 50)
            Divider()
            CustomText(text: description, size: 18)
                .lineLimit(6)
            Spacer()
        }
        .listRowSeparator(.hidden)
    }
}
