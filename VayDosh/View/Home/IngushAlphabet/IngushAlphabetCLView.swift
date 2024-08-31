//
//  IngushAlphabetView.swift
//  VayDosh
//
//  Created by Adam Miziev on 5/23/23.
//

import SwiftUI

struct IngushAlphabetCLView: View {
    
    private let alphabetCyrillic: [(character: String, transcription: String)] = [
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
    private let alphabetLatin: [(character: String, transcription: String)] = [
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
        VStack(alignment: .trailing) {
            SwitchAlphabetButton(switchAlphabet: $switchLatin,
                                 alphabet: "Latin")
            .padding(.horizontal)
            AlphabetView(alphabet: switchLatin ? alphabetLatin
                         : alphabetCyrillic)
        }
    }
}

struct IngushAlphabetCLView_Previews: PreviewProvider {
    static var previews: some View {
        IngushAlphabetCLView()
    }
}
