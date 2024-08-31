//
//  SwitchAlphabetButton.swift
//  VayDosh
//
//  Created by Adam Miziev on 8/25/24.
//

import SwiftUI

struct SwitchAlphabetButton: View {
    @Binding var switchAlphabet: Bool
    
    var alphabet: String
    
    var body: some View {
        Button {
            withAnimation {
                switchAlphabet.toggle()
            }
        } label: {
            HStack {
                CustomText(text: alphabet, size: 14, color: .accentColor)
                Image(systemName: switchAlphabet ? "checkmark.circle.fill" 
                      : "circle")
            }
        }
    }
}
