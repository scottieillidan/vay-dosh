//
//  CustomLinkView.swift
//  VayDosh
//
//  Created by Adam Miziev on 8/30/24.
//

import SwiftUI

struct CustomLinkView: View {
    var url: String
    var title: String
    var socials: [(title: String, social: String)] = [
        (title: "Support", social: "telegram"),
        (title: "GitHub", social: "github")
    ]
    var body: some View {
        Link(destination: URL(string: url)!) {
            HStack{
                HStack {
                    ForEach(socials.indices, id: \.self) { index in
                        if(title == socials[index].title) {
                            Image(socials[index].social)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .padding(.leading, -3.5)
                        }
                    }
                    CustomText(text: title, size: 17)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .font(Font.footnote.bold())
            }
        }
        .foregroundStyle(.secondary.opacity(0.6))
        .listRowSeparator(.hidden)
    }
}

