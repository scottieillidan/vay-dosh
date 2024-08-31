//
//  CustomNavigationTitle.swift
//  VayDosh
//
//  Created by Adam Miziev on 8/31/24.
//

import SwiftUI

struct CustomNavigationTitle: View {
    var title: String
    var body: some View {
        CustomText(text: title, size: 28, weight: .bold)
    }
}
