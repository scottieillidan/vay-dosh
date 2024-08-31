//
//  SectionHeaderView.swift
//  VayDosh
//
//  Created by Adam Miziev on 8/30/24.
//

import SwiftUI

struct SectionHeaderView: View {
    var icon: String
    var section: String
    var body: some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 25)
                .foregroundColor(.accentColor)
            CustomText(text: section, size: 13, color: .secondary)
        }
    }
}
