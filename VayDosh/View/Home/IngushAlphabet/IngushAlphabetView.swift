//
//  IngushAlphabetView.swift
//  VayDosh
//
//  Created by Adam Miziev on 5/25/23.
//

import SwiftUI

struct IngushAlphabetView: View {
    
    @State private var showAlphabet = false
    
    var body: some View {
        VStack {
            ShowAlphabetButton(showAlphabet: $showAlphabet)
            if showAlphabet {
                IngushAlphabetCLView()
            }
        }
    }
}
