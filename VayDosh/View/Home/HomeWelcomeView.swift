//
//  HomeWelcomeView.swift
//  VayDosh
//
//  Created by Adam Miziev on 8/31/24.
//

import SwiftUI

struct HomeWelcomeView: View {
    @FetchRequest(entity: Item.entity(), sortDescriptors: [
                        NSSortDescriptor(keyPath: \Item.dictionary, ascending: false)
                    ], predicate: NSPredicate(format: "dictionary == %@", "КУР05"))
    
    private var randomWords: FetchedResults<Item>
    
    @StateObject private var keyboardResponder = KeyboardResponder()
    @State private var randomWord: Item? = nil
    
    @Binding var isShowTranslate: Bool
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 20.0) {
                VStack(alignment: .leading) {
                    CustomText(text: "ING", size: 13, weight: .black)
                    CustomText(text: randomWord?.ingush ??
                               "Марш доаг1алда Шо!", size: 28, weight: .black)
                }
                ShowTranslationButton(isShowTranslate: $isShowTranslate, 
                                      word: randomWord?.russian)
            }
            Spacer()
            if !randomWords.isEmpty && !keyboardResponder.isKeyboardVisible {
                DiceButton(isShowTranslate: $isShowTranslate,
                           randomWord: $randomWord,
                           randomWords: randomWords)
            }
        }
        .padding(30)
    }
}
