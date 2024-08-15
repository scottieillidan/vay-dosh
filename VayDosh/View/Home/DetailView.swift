//
//  DetailView.swift
//  VayDosh
//
//  Created by Adam Miziev on 5/2/23.
//

import SwiftUI

struct DetailView: View {
    
    @AppStorage("language") private var language = 
    LocalizationService.shared.language
    
    @State var shareText: ShareText?
    @State var isPresented = false
    
    @Environment(\.managedObjectContext) var context
    
    @ObservedObject var loadedData: Item
    
    @EnvironmentObject var buttonSwitch: SwitchLangModel
    
    var body: some View {
        
        let condition = loadedData.dictionary! == "УЖА27"
        || loadedData.dictionary! == "ИТС33"
        
        let text = "(VayDosh)".localized(language) +
        "\n" + "ING: ".localized(language) +
        "\(loadedData.ingush!)" + "| " +
        "RU: ".localized(language) +
        "\(loadedData.russian!)"
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                VStack(alignment: .leading) {
                    Button {
                        self.isPresented.toggle()
                    } label: {
                        HStack {
                            Text("Dictionary:".localized(language))
                            Text("\(loadedData.dictionary!)")
                        }
                        .font(.title.weight(.bold))
                        .padding(.bottom, 10)
                    }
                    .sheet(isPresented: $isPresented, 
                           content: { VocabularyView() })
                    VStack(alignment: .leading) {
                        if !buttonSwitch.switchLang {
                            if condition {
                                HStack {
                                    Text("Latin".localized(language))
                                    Text("|")
                                    Text("Cyrillic".localized(language))
                                }
                                .font(.footnote)
                                .foregroundColor(.secondary)
                            }
                        }
                        HStack {
                            Text(buttonSwitch.switchLang ? 
                                 "RU".localized(language) :
                                    "ING".localized(language))
                                .font(.footnote)
                                .fontWeight(.black)
                                .padding(.bottom, 2)
                            Spacer()
                        }
                        Text(buttonSwitch.switchLang ? 
                             "\(loadedData.russian!)" :
                                "\(loadedData.ingush!)")
                        Divider()
                        if buttonSwitch.switchLang {
                            if condition {
                                HStack {
                                    Text("Latin".localized(language))
                                    Text("|")
                                    Text("Cyrillic".localized(language))
                                }
                                .font(.footnote)
                                .foregroundColor(.secondary)
                            }
                        }
                        HStack {
                            Text(buttonSwitch.switchLang ? 
                                 "ING".localized(language) :
                                    "RU".localized(language))
                                .font(.footnote)
                                .fontWeight(.black)
                                .padding(.bottom, 2)
                            Spacer()
                        }
                        Text(buttonSwitch.switchLang ? 
                             "\(loadedData.ingush!)" : "\(loadedData.russian!)")
                        Divider()
                    }
                } // VStack
                .padding()
                Spacer()
                IngushAlphabetView()
                    .padding(.horizontal)
                    .padding(.bottom)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        loadedData.isFavorite.toggle()
                        loadedData.favoritedOrder = 
                        Int32(Date().timeIntervalSince1970)
                        do {
                            try context.save()
                        } catch {
                            print(error.localizedDescription)
                        }
                        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                    } label: {
                        Image(systemName: loadedData.isFavorite ? 
                              "star.fill" : "star" )
                            .foregroundColor(Color.yellow)
                    }
                }
                ToolbarItem {
                    VStack {
                        Button {
                            shareText = ShareText(text: text)
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                        }
                    }.sheet(item: $shareText) { shareText in
                        ActivityView(text: shareText.text)
                    }
                }
            }
        }
    }
}
