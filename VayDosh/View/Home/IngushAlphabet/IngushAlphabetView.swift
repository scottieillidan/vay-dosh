//
//  IngushAlphabetView.swift
//  VayDosh
//
//  Created by Adam Miziev on 5/25/23.
//

import SwiftUI

struct IngushAlphabetView: View {
    @AppStorage("language") private var language = LocalizationService.shared.language
    
    @State private var showAlphabet = false
    
    var body: some View {
        VStack {
            ShowAlphabetButton(showAlphabet: $showAlphabet)
            if showAlphabet {
                IngushAlphabetCLView()
            } else {
                Spacer()
            }
        }
    }
}

struct IngushAlphabetView_Previews: PreviewProvider {
    static var previews: some View {
        IngushAlphabetView()
    }
}


struct ShowAlphabetButton: View {
    @AppStorage("language") private var language = LocalizationService.shared.language
    
    @Binding var showAlphabet: Bool
    
    var body: some View {
        HStack {
            Button {
                withAnimation {
                    showAlphabet.toggle()
                }
            } label: {
                HStack {
                    Text("Ingush Alphabet".localized(language))
                        .foregroundColor(showAlphabet ? .accentColor : .secondary)
                        
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(showAlphabet ? .accentColor : .secondary)
                        .rotationEffect(.degrees(showAlphabet ? 90 : 0))
                }
                .font(.headline)
            }
            Spacer()
        }
        .padding(.bottom, 5)
    }
}
