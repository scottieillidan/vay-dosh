//
//  SwitchLang.swift
//  VayDosh
//
//  Created by Adam Miziev on 5/16/23.
//

import SwiftUI

class SwitchLang: ObservableObject {
    @AppStorage("SwitchLangKey") var switchLang: Bool = false
    
    func toggleSwitchLang() {
        switchLang.toggle()
    }
}
