//
//  FavoriteListView.swift
//  VayDosh
//
//  Created by Adam Miziev on 5/6/23.
//

import SwiftUI

struct FavoriteWordsListView: View {
    
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(entity: Item.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Item.isFavorite, ascending: false),
    ], predicate: NSPredicate(format: "isFavorite == %@",
                              NSNumber(value: true)))
    
    var favoriteItems: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            VStack {
                if favoriteItems.isEmpty {
                    EmptyFavoriteWordsList()
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack {
                            ForEach(favoriteItems, id: \.self) { item in
                                FavoriteWord(favoriteWord: item)
                            }
                        }
                        .padding()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    CustomNavigationTitle(title: "Favorites")
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
