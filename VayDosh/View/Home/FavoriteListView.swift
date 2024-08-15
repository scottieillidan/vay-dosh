//
//  FavoriteListView.swift
//  VayDosh
//
//  Created by Adam Miziev on 5/6/23.
//

import SwiftUI

struct FavoriteListView: View {
    
    @AppStorage("language") private var language = 
    LocalizationService.shared.language
    
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(entity: Item.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Item.isFavorite, ascending: false),
        NSSortDescriptor(keyPath: \Item.favoritedOrder, ascending: false)
    ], predicate: NSPredicate(format: "isFavorite == %@", 
                              NSNumber(value: true)))
    
    var favoriteItems: FetchedResults<Item>

    var body: some View {
        NavigationView {
            VStack {
                if favoriteItems.isEmpty {
                    EmptyFavoriteList()
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack {
                            ForEach(favoriteItems, id: \.self) { item in
                                CardItem(cardItem: item)
                            }
                        }
                        .padding()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                        Text("Favorites".localized(language))
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct CardItem: View {
    
    @Environment(\.managedObjectContext) var context
    
    @ObservedObject var cardItem: Item
    
    @AppStorage("language") private var language = 
    LocalizationService.shared.language
    
    var body: some View {
        let condition = cardItem.dictionary! == "УЖА27"
        || cardItem.dictionary! == "ИТС33"
        ZStack(alignment: .trailing) {
            VStack(alignment: .leading, spacing: 8.0) {
                HStack {
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text("Dictionary:".localized(language))
                            .font(.footnote)
                            .fontWeight(.black)
                            .foregroundColor(.secondary)
                        Text(cardItem.dictionary!)
                            .font(.headline)
                            .fontWeight(.light)
                    }
                    Spacer()
                    Button {
                        withAnimation {
                            if cardItem.isFavorite {
                                cardItem.isFavorite.toggle()
                                UIImpactFeedbackGenerator(style:
                                        .soft).impactOccurred()
                                do {
                                    try context.save()
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }

                }
                Divider()
                Text("ING".localized(language))
                    .font(.footnote)
                    .fontWeight(.black)
                if condition {
                    HStack {
                        Text("Latin".localized(language))
                        Text("|")
                        Text("Cyrillic".localized(language))
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top, -5)
                }
                Text(cardItem.ingush!)
                    .font(.headline)
                    .fontWeight(.light)
                    .padding(.top, -5)
                Text("RU".localized(language))
                    .font(.footnote)
                    .fontWeight(.black)
                Text(cardItem.russian!)
                    .font(.headline)
                    .fontWeight(.light)
                
            }
            .frame(maxWidth: .infinity)
            .padding(20)
            .background(Color("SecondarySystemBG"))
            .cornerRadius(10)
        }
    }
}


struct EmptyFavoriteList: View {
    @AppStorage("language") private var language =
    LocalizationService.shared.language
    var body: some View {
        VStack {
            Spacer()
            VStack {
                ZStack {
                    LottieView(loopMode: .playOnce, animationName: "gold-star")
                        .frame(width: 150, height: 150)
                    LottieView(loopMode: .loop, animationName: "shining-stars")
                        .frame(height: 150)
                }
                Text("No Favorites yet".localized(language))
                    .font(.title.weight(.bold))
                    .multilineTextAlignment(.center)
                HStack {
                    Text("Add words using ".localized(language))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
            }
            .padding()
            Spacer()
        }
    }
}
