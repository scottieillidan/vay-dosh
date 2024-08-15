//
//  SwitchLangModel.swift
//  VayDosh
//
//  Created by Adam Miziev on 5/16/23.
//

import Foundation

class SwitchLangModel: ObservableObject {
    @Published var switchLang:
    Bool = UserDefaults.standard.bool(forKey: "SwitchLangKey") {
        didSet {
            UserDefaults.standard.set(switchLang, forKey: "SwitchLangKey")
        }
    }
    
    func toggleSwitchLang() {
        switchLang.toggle()
    }
}

