//
//  Language.swift
//  VayDosh
//
//  Created by Adam Miziev on 5/19/23.
//

import Foundation

enum Language: String {

    case english_us = "en"
    case russian = "ru"
    case ingush = "inh"
    
    var userSymbol: String {
        switch self {
        case .english_us:
            return "us"
        default:
            return rawValue
        }
    }
}
