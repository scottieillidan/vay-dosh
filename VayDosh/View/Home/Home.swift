//
//  Home.swift
//  VayDosh
//
//  Created by Adam Miziev on 5/2/23.
//

import SwiftUI
import CoreData
import StoreKit

struct Home: View {
    
    @AppStorage("language") private var language = 
    LocalizationService.shared.language
    
    @ObservedObject var jsonModel = JSONViewModel()
    
    @Environment(\.managedObjectContext) var context
    
    @State private var buttonTapped = 0
    
    @FetchRequest(entity: Item.entity(), sortDescriptors: 
                    [NSSortDescriptor(keyPath: \Item.russian,
                                      ascending: true)])
    var rusResults : FetchedResults<Item>
    
    @FetchRequest(entity: Item.entity(), sortDescriptors: 
                    [NSSortDescriptor(keyPath: \Item.ingush,
                                      ascending: true)])
    var ingResults : FetchedResults<Item>
    
    @FetchRequest(entity: Item.entity(), sortDescriptors: 
                    [NSSortDescriptor(keyPath: \Item.dictionary,
                                      ascending: true)],
                  predicate: NSPredicate(format: "dictionary == %@", "КУР05"))
    var randomWords: FetchedResults<Item>
    
    @State private var searchText = ""
    @State private var filteredResults: [Item] = []
    
    private let filterQueue = DispatchQueue(label: "FilterQueue", 
                                            qos: .userInitiated)
    
    @EnvironmentObject var buttonSwitch: SwitchLangModel
    
    @State private var randomWord: Item? = nil
    @State var isShowTranslate = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: Alignment(horizontal: .trailing, 
                                        vertical: .bottom)) {
                VStack {
                    if searchText.isEmpty {
                        VStack {
                            Spacer()
                            VStack(spacing: 20.0) {
                                VStack(alignment: .leading) {
                                    Text("ING".localized(language))
                                        .font(.footnote)
                                        .fontWeight(.black)
                                    Text(randomWord?.ingush ?? 
                                         "Марш доаг1алда Шо!")
                                        .font(.title.weight(.black))
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(7)
                                }
                                ZStack {
                                    Button {
                                        withAnimation {
                                            isShowTranslate.toggle()
                                        }
                                    } label: {
                                        Text("Show translate".localized(
                                            language))
                                            .font(.body.weight(.bold))
                                            .padding(.vertical, 13)
                                            .padding(.horizontal, 60)
                                            .foregroundColor(.primary)
                                            .background(Color.accentColor)
                                            .cornerRadius(30)
                                            .clipShape(Capsule())
                                    }
                                    .opacity(isShowTranslate ? 0 : 1)
                                    VStack(alignment: .leading) {
                                        Text(randomWord?.russian ?? 
                                             "Welcome!".localized(language))
                                            .font(.title2.weight(.thin))
                                            .multilineTextAlignment(.leading)
                                            .lineLimit(7)
                                    }
                                    .opacity(isShowTranslate ? 1 : 0)
                                    
                                }
                            }
                            Spacer()
                        }
                        .padding()
                        if !randomWords.isEmpty {
                            HStack {
                                Spacer()
                                Button {
                                    withAnimation {
                                        self.randomWord = 
                                        self.randomWords.randomElement()
                                        UIImpactFeedbackGenerator(style:
                                                .soft).impactOccurred()
                                        if isShowTranslate {
                                            self.isShowTranslate.toggle()
                                        }
                                        if buttonTapped != 35 {
                                            buttonTapped += 1
                                        }
                                        if buttonTapped == 35 {
                                            guard let currentScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                                                  return
                                            }

                                            SKStoreReviewController
                                                .requestReview(in: currentScene)
                                            buttonTapped = 0
                                        }
                                    }
                                } label: {
                                    Image(systemName: "dice.fill")
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                }
                            }
                            .offset(x: -20, y: -30)
                        }
                    } else {
                        // Display fetched core data...
                        if filteredResults.isEmpty {
                            VStack {
                                LottieView(loopMode: .loop, 
                                           animationName: "empty")
                                    .frame(width: 150, height: 100)
                                    .scaleEffect(0.4)
                                    .padding(.vertical)
                                Text("No Results".localized(language))
                                    .font(.title2.weight(.bold))
                                    .multilineTextAlignment(.center)
                                VStack {
                                    Text("There were no results for".localized(
                                        language))
                                    Text("\"\(searchText)\".")
                                }
                                .font(.title3)
                                .multilineTextAlignment(.center)
                                Text("Try a new search.".localized(language))
                                    .font(.title3)
                                    .multilineTextAlignment(.center)
                            }
                            .padding()
                        } else {
                            ScrollView(.vertical, showsIndicators: false) {
                                LazyVStack {
                                    ForEach(filteredResults.prefix(30), 
                                            id: \.self) { word in
                                        NavigationLink(destination: 
                                                        DetailView(loadedData:
                                                                    word)) {
                                            if word != 
                                                filteredResults.prefix(30).last {
                                                VStack {
                                                    ListItemView(loadedData: word)
                                                    Divider()
                                                }
                                            } else {
                                                ListItemView(loadedData: word)
                                            }
                                        }
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.primary)
                                .background(Color("SecondarySystemBG"))
                                .cornerRadius(8)
                                .shadow(color: 
                                            Color("SecondarySystemBG").opacity(0.4),
                                        radius: 4, x: 0, y: 2)
                                .padding()
                            }
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $searchText, 
                            placement: .navigationBarDrawer(displayMode:
                                    .always), prompt:
                                "Search".localized(language)) {
                    if ingResults.isEmpty {
                        if jsonModel.words.isEmpty {
                            HStack {
                                Spacer()
                                VStack {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: 
                                                .accentColor))
                                        .scaleEffect(1.5)
                                        .padding(.vertical)
                                        .onAppear {
                                            jsonModel.loadData(context: context)
                                    }
                                }
                                Spacer()
                            }
                        }
                    }
                }
                .animation(.default, value: searchText)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack {
                            Image("Emblem")
                                .resizable()
                                .interpolation(.high)
                                .scaledToFit()
                                .frame(width: 90, height: 90)
                                .padding(.trailing, -30)
                                .padding(.leading, -25)
                            Text("VayDosh".localized(language))
                                .font(.title)
                                .fontWeight(.bold)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            buttonSwitch.toggleSwitchLang()
                            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                        } label: {
                            HStack {
                                Text(buttonSwitch.switchLang ? 
                                     "RU".localized(language) :
                                        "ING".localized(language))
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                    .foregroundColor(buttonSwitch.switchLang ? 
                                                     Color("SwitchButtonRedColor") :
                                            .accentColor)
                                    .frame(width: 50)
                                    .padding(.horizontal, -10)
                                Image(buttonSwitch.switchLang ? "RUING" : "INGRU")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 35, height: 35)
                                Text(buttonSwitch.switchLang ? 
                                     "ING".localized(language) :
                                        "RU".localized(language))
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                    .foregroundColor(buttonSwitch.switchLang ? 
                                        .accentColor : Color("SwitchButtonRedColor"))
                                    .frame(width: 50)
                                    .padding(.horizontal, -10)
                                
                            }
                            .padding(.trailing, 10)
                        }
                    }
            }
            }
            
        } // NavigationView
        .navigationViewStyle(StackNavigationViewStyle())
        .onChange(of: searchText) { searchText in
            filterResults()
        }
    }
    private func filterResults() {
        if buttonSwitch.switchLang {
            filterQueue.async {
                let startsWithPredicate = NSPredicate(format: "russian BEGINSWITH[c] %@", self.searchText)
                let containsPredicate = NSPredicate(format: "russian CONTAINS[c] %@", self.searchText)
                let compoundPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [startsWithPredicate, containsPredicate])
                
                let filtered = self.rusResults.filter { compoundPredicate.evaluate(with: $0) }
                
                let sortedFiltered = filtered.sorted { (item1, item2) in
                    let item1StartsWith = startsWithPredicate.evaluate(with: item1)
                    let item2StartsWith = startsWithPredicate.evaluate(with: item2)
                    
                    if item1StartsWith && !item2StartsWith {
                        return true
                    } else if !item1StartsWith && item2StartsWith {
                        return false
                    } else {
                        return item1.russian ?? "" < item2.russian ?? ""
                    }
                }
                
                DispatchQueue.main.async {
                    self.filteredResults = sortedFiltered
                }
            }
        } else {
            filterQueue.async {
                let startsWithPredicate = NSPredicate(format: "ingush BEGINSWITH[c] %@", self.searchText)
                let containsPredicate = NSPredicate(format: "ingush CONTAINS[c] %@", self.searchText)
                let compoundPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [startsWithPredicate, containsPredicate])
                
                let filtered = self.ingResults.filter { compoundPredicate.evaluate(with: $0) }
                
                let sortedFiltered = filtered.sorted { (item1, item2) in
                    let item1StartsWith = startsWithPredicate.evaluate(with: item1)
                    let item2StartsWith = startsWithPredicate.evaluate(with: item2)
                    
                    if item1StartsWith && !item2StartsWith {
                        return true
                    } else if !item1StartsWith && item2StartsWith {
                        return false
                    } else {
                        return item1.ingush ?? "" < item2.ingush ?? ""
                    }
                }
                
                DispatchQueue.main.async {
                    self.filteredResults = sortedFiltered
                }
            }
        }
    }
}
