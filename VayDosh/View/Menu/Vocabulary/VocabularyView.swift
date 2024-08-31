//
//  VocabularyView.swift
//  VayDosh
//
//  Created by Adam Miziev on 5/5/23.
//

import SwiftUI

struct VocabularyView: View {
    
    private let vocabulary: [(code: String, description: String)] = [
        ("ПТИ09", "— Кодзоев Н.Д. — Птицы: ингушско-русский словарь. — 2009"),
        ("УЖА27", "— Ужахов М.Г. Ингушско-русский словарь. — 1927"),
        ("ИТС33", "— Мальсагов З.К. Ингушский терминологический сборник. — 1933"),
        ("ИРсНС", "— Ингушско-русский словарь неизвестного составителя."),
        ("КУР05", "— Куркиев А.С. Ингушско-русский словарь: 11142 слова. — 2005"),
        ("ДУД15", "— Дударов А-М.М. Земледелие ингушей. — 2015"),
        ("ИРТ16", "— Барахоева Н.М., Кодзоев Н.Д., Хайров Б.А. Ингушско-русский и русско-ингушский словарь терминов: более 8200 слов. — 2016"),
        ("КОДКТ", "— Кодзоев Н.Д. Словарь компьютерных терминов. — 2016"),
        ("МЕД19", "— Кодзоев Н.Д. Медицина. Русско-ингушский словарь. — 2019"),
        ("КОД21", "— Кодзоев Н.Д. Русско-ингушский словарь (около 22 500 слов). — 2021"),
        ("СЕЛААД", "— «СелаӀад» («Радуга»). — Детский журнал."),
        ("РАЗ01", "— Названия месяцев по разным авторам: Дахкильгов И.; Мерешков С.; Патиев Я.; Арчаков С.; Матенаькъан И."),
        ("РАЗ02", "— Ислам (Словарь к Тафсиру Корана на ингушском языке)."),
        ("ХАЙОР", "— Хайров Б. Наименование древнего и средневекового оружия на ингушском языке. — 2012")
    ]
    
    var body: some View {
        List {
            Section(
                header: HStack {
                    CustomText(text: "Code", size: 13, color: .secondary)
                    Spacer()
                    CustomText(text: "Bibliographic Reference", size: 13, color: .secondary)
                }
            ) {
                ForEach(vocabulary.indices, id: \.self) { index in
                    VocabularyItem(
                        code: vocabulary[index].code,
                        description: vocabulary[index].description
                    )
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct VocabularyView_Previews: PreviewProvider {
    static var previews: some View {
        VocabularyView()
    }
}
