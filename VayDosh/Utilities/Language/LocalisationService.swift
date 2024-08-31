//
//  LocalisationService.swift
//  Doshlorg
//
//  Created by Adam Miziev on 5/19/23.
//

import Foundation

class LocalizationService {

    static let shared = LocalizationService()
    static let changedLanguage = Notification.Name("changedLanguage")
    
    var language: Language {
        get {
            guard let languageString = UserDefaults.standard.string(forKey: "language") else {
                return .russian
            }
            return Language(rawValue: languageString) ?? .russian
        } set {
            if newValue != language {
                UserDefaults.standard.setValue(newValue.rawValue, forKey: "language")
                NotificationCenter.default.post(name: LocalizationService.changedLanguage, object: nil)
            }
        }
    }
}
