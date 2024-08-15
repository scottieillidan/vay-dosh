//
//  DisplayMode.swift
//  VayDosh
//
//  Created by Adam Miziev on 7/17/23.
//

import SwiftUI


enum DisplayMode: Int {
    case system, dark, light
    
    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .dark: return ColorScheme.dark
        case .light: return ColorScheme.light
        }
    }
    
    func setAppDisplayMode() {
        var userInterfaceStyle: UIUserInterfaceStyle
        switch self {
        case .system: userInterfaceStyle = .unspecified
        case .dark: userInterfaceStyle = .dark
        case .light: userInterfaceStyle = .light
        }
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        scene?.keyWindow?.overrideUserInterfaceStyle = userInterfaceStyle
    }
}
