//
//  ListItemView.swift
//  VayDosh
//
//  Created by Adam Miziev on 5/2/23.
//

import SwiftUI

struct ListItemView: View {
    
    @AppStorage("language") private var language = 
    LocalizationService.shared.language
    
    @ObservedObject var loadedData: Item
    
    @EnvironmentObject var buttonSwitch: SwitchLangModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10){
                HStack {
                    Text("Dictionary:".localized(language))
                    Text("\(loadedData.dictionary!)")
                }
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.bottom, -10)
                Text(buttonSwitch.switchLang ? 
                     loadedData.russian! : loadedData.ingush!)
                    .multilineTextAlignment(.leading)
                    .font(.headline)
                    .lineLimit(3)
                Text(buttonSwitch.switchLang ? 
                     loadedData.ingush! : loadedData.russian!)
                    .multilineTextAlignment(.leading)
                    .font(.subheadline)
                    .lineLimit(3)
                
            }
            Spacer()
            if loadedData.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(Color.yellow)
            }
            Image(systemName: "chevron.right")
        }
    }
}
