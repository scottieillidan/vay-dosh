//
//  ShowAlphabetButton.swift
//  VayDosh
//
//  Created by Adam Miziev on 8/26/24.
//

import SwiftUI

struct ShowAlphabetButton: View {
    @Binding var showAlphabet: Bool
    
    var body: some View {
        Button {
            withAnimation {
                showAlphabet.toggle()
            }
        } label: {
            HStack {
                CustomText(text: "Ingush Alphabet",
                           size: 18, weight: .medium,
                           color: showAlphabet ? .accentColor : .secondary)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(showAlphabet ? Color.accentColor : .secondary)//ch
                    .rotationEffect(.degrees(showAlphabet ? 90 : 0))
                    .font(.headline)
            }
        }
        .padding(.bottom, 5)
    }
}
