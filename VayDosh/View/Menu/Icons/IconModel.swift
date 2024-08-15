//
//  IconModel.swift
//  VayDosh
//
//  Created by Adam Miziev on 5/2/23.
//

import Foundation
import UIKit

enum Icon: String, CaseIterable, Identifiable {
    
    var id: String { self.rawValue }
    case primary    = "AppIcon"
    case dark       = "AppIcon-Dark"
    case light      = "AppIcon-Light"
    case ingFlag     = "AppIcon-IngushFlag"
    case cartoon     = "AppIcon-Cartoon"
    case cyberpunk     = "AppIcon-2077"
    
    
    var description: String {
        switch self {
        case .primary:
            return "Jeirah"
        case .dark:
            return "Dark"
        case .light:
            return "Light"
        case .ingFlag:
            return "Ingush Flag"
        case .cartoon:
            return "Cartoon"
        case .cyberpunk:
            return "2077"
        }
    }
}

class AppIconModel: ObservableObject, Equatable {
    @Published var appIcon: Icon = .primary
    
    static func == (lhs: AppIconModel, rhs: AppIconModel) -> Bool {
        return lhs.appIcon == rhs.appIcon
    }
    
    /// Change the app icon.
    /// - Tag: setAlternateAppIcon
    func setAlternateAppIcon(icon: Icon) {
        // Set the icon name to nil to use the primary icon.
        let iconName: String? = (icon != .primary) ? icon.rawValue : nil
        
        // Avoid setting the name if the app already uses that icon.
        guard UIApplication.shared.alternateIconName != iconName else { return }
        
        UIApplication.shared.setAlternateIconName(iconName) { (error) in
            if let error = error {
                print("Failed request to update the app’s icon: \(error)")
            }
        }
        
        appIcon = icon
    }
    
    /// Initializes the model with the current state of the app's icon.
    init() {
        let iconName = UIApplication.shared.alternateIconName
        
        if iconName == nil {
            appIcon = .primary
        } else {
            appIcon = Icon(rawValue: iconName!)!
        }
    }
}
