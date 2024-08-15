//
//  IconChooser.swift
//  VayDosh
//
//  Created by Adam Miziev on 5/2/23.
//

import SwiftUI

struct IconChooser: View {
    
    let rows = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @EnvironmentObject var model: AppIconModel
    
    @AppStorage("language") private var language = 
    LocalizationService.shared.language
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: rows, spacing: 20) {
                ForEach(Icon.allCases) { icon in
                    Button(action: {
                        model.setAlternateAppIcon(icon: icon)
                        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                    }) {
                        VStack {
                            Image(icon.rawValue + "-Preview")
                                .resizable()
                                .interpolation(.high)
                                .frame(width: 90, height: 90)
                                .shadow(radius: 5)
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(icon == model.appIcon ? 
                                                Color.accentColor :
                                                    Color.clear, lineWidth: 5)
                                )
                            Text(icon.description.localized(language))
                                .font(.footnote)
                                .foregroundColor(icon == model.appIcon ? 
                                                 Color.accentColor :
                                                    Color.secondary)
                            
                        }
                    }
                }
            } // LazyVGrid
            .padding()
        } // ScrollView
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct IconChooser_Previews: PreviewProvider {
    static var previews: some View {
        IconChooser()
            .environmentObject(AppIconModel())
    }
}
