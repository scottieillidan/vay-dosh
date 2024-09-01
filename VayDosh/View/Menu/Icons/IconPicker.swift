//
//  IconChooser.swift
//  VayDosh
//
//  Created by Adam Miziev on 5/2/23.
//

import SwiftUI

struct IconPicker: View {
    
    @AppStorage("active-icon") private var activeAppIcon: String = "AppIcon"
    
    private var icons: [(appIcon: String, iconName: String)] = [
        ("AppIcon", "Jeirah"),
        ("AppIcon-Dark", "Dark"),
        ("AppIcon-Light", "Light"),
        ("AppIcon-IngushFlag", "Ingush Flag"),
        ("AppIcon-Gradient", "Gradient")
    ]
    
    var body: some View {
        Picker("", selection: $activeAppIcon) {
            ForEach(icons.indices, id: \.self) { index in
                CustomText(text: icons[index].iconName)
                    .tag(icons[index].appIcon)
            }
        }
        .pickerStyle(.menu)
        .onChange(of: activeAppIcon) { newValue in
            if(newValue == "AppIcon") {
                UIApplication.shared.setAlternateIconName(nil)
            } else {
                UIApplication.shared.setAlternateIconName(newValue)
            }
        }
    }
}
