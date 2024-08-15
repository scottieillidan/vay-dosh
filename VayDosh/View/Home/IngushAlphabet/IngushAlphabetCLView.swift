//
//  IngushAlphabetView.swift
//  VayDosh
//
//  Created by Adam Miziev on 5/23/23.
//

import SwiftUI

struct IngushAlphabetCLView: View {
    
    let alphabetCyrillic: [(character: String, transcription: String)] = [
        ("А", "а"),
        ("Аь", "аь"),
        ("Б", "бэ"),
        ("В", "вэ"),
        ("Г", "гэ"),
        ("ГӀ", "гӀа"),
        ("Д", "дэ"),
        ("Е", "е"),
        ("Ë", "ё"),
        ("Ж", "жэ"),
        ("З", "зэ"),
        ("И", "и"),
        ("Й", "йот"),
        ("К", "ка"),
        ("Кх", "кха"),
        ("Къ", "къа"),
        ("КӀ", "кӀа"),
        ("Л", "эл"),
        ("М", "эм"),
        ("Н", "эн"),
        ("О", "о"),
        ("П", "пэ"),
        ("ПӀ", "пӀа"),
        ("Р", "эр"),
        ("С", "эс"),
        ("Т", "тэ"),
        ("ТӀ", "тӀ"),
        ("У", "у"),
        ("Ф", "эф"),
        ("Х", "ха"),
        ("Хь", "хьа"),
        ("ХӀ", "хӀа"),
        ("Ц", "цэ"),
        ("ЦӀ", "цӀа"),
        ("Ч", "чэ"),
        ("ЧӀ", "ч1"),
        ("Ш", "ша"),
        ("Щ", "ща"),
        ("Ъ", " "),
        ("Ы", "ы"),
        ("Ь", " "),
        ("Э", "э"),
        ("Ю", "ю"),
        ("Я", "я"),
        ("Яь", "яь"),
        ("Ӏ", "'")
    ]
    let alphabetLatin: [(character: String, transcription: String)] = [
        ("A", "ei"),
        ("Æ", "alæp"),
        ("B", "be"),
        ("Ä", " "),
        ("C", "ce"),
        ("Č", "че"),
        ("D", "de"),
        ("E", "e"),
        ("F", "ef"),
        ("G", "ge"),
        ("H", "hain"),
        ("ꜧ", "ꜧej"),
        ("I", "i"),
        ("J", "jot"),
        ("K", "ka"),
        ("L", "el"),
        ("M", "em"),
        ("N", "en"),
        ("O", "o"),
        ("P", "pe"),
        ("Q", "qa"),
        ("R", "er"),
        ("S", "es"),
        ("Š", "ше"),
        ("T", "te"),
        ("U", "u"),
        ("V", "vov"),
        ("X", "xa"),
        ("X́", " "),
        ("Y", "yz"),
        ("Z", "zet"),
        ("Ž", "же")
    ]
    
    @State private var switchLatin = false
    
    var body: some View {
        HStack {
            Spacer()
            SwitchAlphabetButton(switchAlphabet: $switchLatin, alphabet: "Latin")
        }
        .padding(.horizontal)
        AlphabetView(alphabet: switchLatin ? alphabetLatin : alphabetCyrillic)
    }
}

struct IngushAlphabetCLView_Previews: PreviewProvider {
    static var previews: some View {
        IngushAlphabetCLView()
    }
}


struct AlphabetView: View {
    let alphabet: [(character: String, transcription: String)]
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(0..<alphabet.count, id: \.self) { letter in
                VStack {
                    Text(alphabet[letter].character)
                        .font(.title)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    
                    Text(alphabet[letter].transcription)
                        .font(.subheadline)
                        .lineLimit(1)
                        .padding(.top, 5)
                }
                .padding(5)
                .background()
                .cornerRadius(20)
            }
        }
        .padding()
        .background(Color("SecondarySystemBG"))
        .cornerRadius(40)
    }
}


struct SwitchAlphabetButton: View {
    @AppStorage("language") private var language = LocalizationService.shared.language
    @Binding var switchAlphabet: Bool
    var alphabet: String
    var body: some View {
        Button {
            switchAlphabet.toggle()
        } label: {
            HStack {
                Text(alphabet.localized(language))
                    .font(.footnote)
                Image(systemName: switchAlphabet ? "checkmark.circle.fill" : "circle")
            }
        }
    }
}
