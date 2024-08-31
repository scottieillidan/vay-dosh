//
//  FavoriteButton.swift
//  VayDosh
//
//  Created by Adam Miziev on 8/25/24.
//

import SwiftUI

struct FavoriteButton: View {
    @Environment(\.managedObjectContext) private var context
    
    @Binding var isFavorite: Bool
    
    var body: some View {
        Button {
            withAnimation {
                isFavorite.toggle()
                UIImpactFeedbackGenerator(style:
                        .soft).impactOccurred()
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        } label: {
            Image(systemName: isFavorite ? "star.fill" : "star")
                .foregroundColor(.yellow)
        }
    }
}
