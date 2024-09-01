//
//  Home.swift
//  VayDosh
//
//  Created by Adam Miziev on 5/2/23.
//

import SwiftUI
import CoreData
import StoreKit

struct HomeView: View {
    
    @AppStorage("language") private var language =
    LocalizationService.shared.language
    
    @EnvironmentObject var switchLang: SwitchLang
    @Environment(\.managedObjectContext) var context
    
    @StateObject private var keyboardResponder = KeyboardResponder()
    
    @ObservedObject var wordModel = WordViewModel()
    
    @FetchRequest(entity: Item.entity(), sortDescriptors:
                    [NSSortDescriptor(keyPath: \Item.russian,
                                      ascending: true)])
    var rusResults : FetchedResults<Item>
    
    @FetchRequest(entity: Item.entity(), sortDescriptors:
                    [NSSortDescriptor(keyPath: \Item.ingush,
                                      ascending: true)])
    var ingResults : FetchedResults<Item>
    
    @State private var searchText = ""
    @State private var filteredResults: [Item] = []
    @State var isShowTranslate = false
    
    private let filterQueue = DispatchQueue(label: "FilterQueue",
                                            qos: .userInitiated)
    
    var body: some View {
        NavigationView {
            VStack {
                if searchText.isEmpty {
                    HomeWelcomeView(isShowTranslate: $isShowTranslate)
                } else {
                    if filteredResults.isEmpty {
                        EmptySearchResult(searchText: $searchText)
                    } else {
                        List {
                            ForEach(filteredResults.prefix(35),
                                    id: \.self) { word in
                                NavigationLink(destination:
                                                DetailView(word:
                                                            word)) {
                                    ListWordView(word: word)
                                }
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    if wordModel.words.isEmpty && ingResults.isEmpty {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint:
                                    .accentColor))
                            .scaleEffect(1.5)
                            .padding(5)
                            .onAppear {
                                wordModel.loadData(context: context)
                            }
                    }
                    CustomNavigationTitle(title: "VayDosh")
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        switchLang.toggleSwitchLang()
                        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                    } label: {
                        SwitchButtonLabel(switchLang: $switchLang.switchLang)
                    }
                }
            }
            .animation(.default, value: searchText)
            .animation(.default, value: filteredResults)
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Search".localized(language))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onChange(of: searchText) { searchText in
            filterResults()
        }
    }
    
    private func filterResults() {
        let languageKey = self.switchLang.switchLang ? "russian" : "ingush"
        let results = self.switchLang.switchLang ? self.rusResults : self.ingResults
        
        filterQueue.async {
            let searchText = self.searchText.lowercased()

            // Filter results
            let filtered = results.filter { item in
                if let value = item.value(forKey: languageKey) as? String {
                    let lowercasedValue = value.lowercased()
                    return lowercasedValue.hasPrefix(searchText) || lowercasedValue.contains(searchText)
                }
                return false
            }
            
            // Sort results: items that start with the search text should come first
            let sortedFiltered = filtered.sorted { (item1, item2) in
                guard let value1 = item1.value(forKey: languageKey) as? String,
                      let value2 = item2.value(forKey: languageKey) as? String else {
                    return false
                }
                
                let lowercasedValue1 = value1.lowercased()
                let lowercasedValue2 = value2.lowercased()
                
                let item1StartsWith = lowercasedValue1.hasPrefix(searchText)
                let item2StartsWith = lowercasedValue2.hasPrefix(searchText)
                
                if item1StartsWith != item2StartsWith {
                    return item1StartsWith
                } else {
                    return lowercasedValue1 < lowercasedValue2
                }
            }

            DispatchQueue.main.async {
                self.filteredResults = sortedFiltered
            }
        }
    }


    
}
