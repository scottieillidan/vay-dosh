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
            .searchable(text: $searchText, placement: .toolbar, prompt: "Search".localized(language))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onChange(of: searchText) { searchText in
            filterResults(searchText)
        }
    }
    
    private func filterResults(_ searchText: String) {
        filterQueue.async {
            let languageKey = self.switchLang.switchLang ? "russian" : "ingush"
            let results = self.switchLang.switchLang ? self.rusResults : self.ingResults

            let startsWithPredicate = NSPredicate(format: "\(languageKey) BEGINSWITH[c] %@", searchText)
            let containsPredicate = NSPredicate(format: "\(languageKey) CONTAINS[c] %@", searchText)
            let compoundPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [startsWithPredicate, containsPredicate])

            let filtered = results.filter { compoundPredicate.evaluate(with: $0) }

            let sortedFiltered = filtered.sorted { (item1, item2) in
                let item1StartsWith = startsWithPredicate.evaluate(with: item1)
                let item2StartsWith = startsWithPredicate.evaluate(with: item2)

                if item1StartsWith && !item2StartsWith {
                    return true
                } else if !item1StartsWith && item2StartsWith {
                    return false
                } else {
                    return (item1.value(forKey: languageKey) as? String ?? "") < (item2.value(forKey: languageKey) as? String ?? "")
                }
            }

            DispatchQueue.main.async {
                self.filteredResults = sortedFiltered
            }
        }
    }

    
}
