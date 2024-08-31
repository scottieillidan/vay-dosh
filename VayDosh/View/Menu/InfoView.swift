//
//  InfoView.swift
//  VayDosh
//
//  Created by Adam Miziev on 5/22/23.
//

import SwiftUI
import UIKit

struct InfoView: View {
    
    @State private var shareText: ShareText?
    
    private let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
    as? String
    
    var body: some View {
        let VDLink = "https://apps.apple.com/tr/app/vaydosh/id6450205976"
        let privacyPolicy = "https://docs.google.com/" +
        "document/d/1Acw-XZaRoO3vw2FTcwhijHmMtpGtizYuoVYRyVPGaVE"
        List {
            VStack(alignment: .leading) {
                CustomText(text: "VayDosh", size: 20, weight: .bold)
                HStack {
                    CustomText(text: "Version:", size: 16, color: .secondary)
                    CustomText(text: appVersion!, size: 16, color: .secondary)
                }
                HStack {
                    CustomText(text: "MZA", size: 18)
                    Spacer()
                    Text(yearFormatter())
                }
            }
            Section(content: {
                CustomLinkView(url: "https://github.com/scottieillidan/vay-dosh",
                               title: "GitHub")
                CustomLinkView(url: "https://ghalghay.github.io/",
                               title: "Set of Ingush Dictionaries")
            }, header: {
                SectionHeaderView(icon: "archivebox", section: "Reference")
            })
            Section(content: {
                CustomLinkView(url: "https://lottiefiles.com/",
                               title: "Lottie Animations")
                CustomLinkView(url: "https://www.flaticon.com/",
                               title: "Icon made by Freepik from Flaticon")
            }, header: {
                SectionHeaderView(icon: "paintpalette",
                                  section: "Graphic Materials")
            })
            Section(content: {
                CustomLinkView(url: privacyPolicy, title: "Privacy Policy")
            }, header: {
                SectionHeaderView(icon: "checkmark.seal", section: "")
            })
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ShareButton(shareText: $shareText,
                            text: "VayDosh: " + VDLink)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func yearFormatter() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y"
        return dateFormatter.string(from: Date())
    }
}
