//
//  VocabularyView.swift
//  VayDosh
//
//  Created by Adam Miziev on 5/5/23.
//

import SwiftUI

struct VocabularyView: View {
    
    @AppStorage("language") private var language = 
    LocalizationService.shared.language
    
    init() {
            UITableView.appearance().showsVerticalScrollIndicator = false
        }
    
    var body: some View {
        List {
            Section (header: HStack {
                Text("Code".localized(language))
                    .frame(width: 50)
                    .padding(.leading, -10)
                Spacer()
                Text("Bibliographic Reference".localized(language))
            }) {
                Group {
                    VocabularyItem(code: "ПТИ09", description: "— Кодзоев Н.Д. — Птицы: ингушско-русский словарь. — 2009")
                    VocabularyItem(code: "УЖА27", description: "— Ужахов М.Г. Ингушско-русский словарь. — 1927")
                    VocabularyItem(code: "ИТС33", description: "— Мальсагов З.К. Ингушский терминологический сборник. — 1933")
                    VocabularyItem(code: "ИРсНС", description: "— Ингушско-русский словарь неизвестного составителя.")
                    VocabularyItem(code: "КУР05", description: "— Куркиев А.С. Ингушско-русский словарь: 11142 слова. — 2005")
                    VocabularyItem(code: "ДУД15", description: "— Дударов А-М.М. Земледелие ингушей. — 2015")
                    VocabularyItem(code: "ИРТ16", description: "— Барахоева Н.М., Кодзоев Н.Д., Хайров Б.А. Ингушско-русский и русско-ингушский словарь терминов: более 8200 слов. — 2016")
                }
                Group {
                    VocabularyItem(code: "КОДКТ", description: "— Кодзоев Н.Д. Словарь компьютерных терминов. — 2016")
                    VocabularyItem(code: "МЕД19", description: "— Кодзоев Н.Д. Медицина. Русско-ингушский словарь. — 2019")
                    VocabularyItem(code: "КОД21", description: "— Кодзоев Н.Д. Русско-ингушский словарь (около 22 500 слов). — 2021")
                    VocabularyItem(code: "СЕЛААД", description: "— «СелаӀад» («Радуга»). — Детский журнал.")
                    VocabularyItem(code: "РАЗ01", description: "— Названия месяцев по разным авторам:  Дахкильгов И.; Мерешков С.; Патиев Я.; Арчаков С.; Матенаькъан И.")
                    VocabularyItem(code: "РАЗ02", description: "— Ислам (Словарь к Тафсиру Корана на ингушском языке).")
                    VocabularyItem(code: "ХАЙОР", description: "— Хайров Б. Наименование древнего и средневекового оружия на ингушском языке. — 2012")
                }
            } // Vocabulary Section
//            Section(content: {
//                Link(destination: URL(string: "https://t.me/adammiziev")!) {
//                    HStack {
//                        Image("telegram")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 35, height: 35)
//                            .padding(.leading, -10)
//                        Text("Telegram")
//                        Spacer()
//                        Image(systemName: "chevron.right")
//                    }
//                    .foregroundColor(Color(red: 0.152, green: 0.66, blue: 0.916))
//                }
//            }, header: {
//                VStack(alignment: .leading) {
//                    Text("If you would like me to delete, edit, or add your own dictionary to the collection, contact me via:".localized(language))
//                }
//            })
        } // List
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct VocabularyView_Previews: PreviewProvider {
    static var previews: some View {
        VocabularyView()
    }
}

struct VocabularyItem: View {
    var code: String
    var description: String
    var body: some View {
        HStack {
            Text(code)
                .frame(width: 50)
                .font(.footnote)
                .foregroundColor(.accentColor)
                .padding(.leading, -10)
            Divider()
            Text(description)
                .lineLimit(6)
            Spacer()
        }
        .listRowSeparator(.hidden)
    }
}
