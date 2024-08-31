//
//  CustomButton.swift
//  VayDosh
//
//  Created by Adam Miziev on 3/18/24.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var subTitle: String
    var icon: String
    var iconColor: Color = .yellow
    
    @AppStorage("language") private var language =
    LocalizationService.shared.language
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title.localized(language))
                    .bold()
                if(subTitle != "") {
                    Text(subTitle.localized(language))
                        .fontWeight(.light)
                        .font(.footnote)
                }
            }
            Spacer().frame(width: 20)
            Image(systemName: icon)
                .foregroundColor(iconColor)
               
        }
        .padding(15)
        .frame(maxWidth: .infinity)
        .frame(height: 90)
        .background(Color.secondaryBG)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
    }
}
