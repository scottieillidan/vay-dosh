//
//  InfoView.swift
//  VayDosh
//
//  Created by Adam Miziev on 5/22/23.
//

import SwiftUI
import UIKit

struct InfoView: View {
    
    @State var shareText: ShareText?
    
    @AppStorage("language") private var language = 
    LocalizationService.shared.language
    
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] 
    as? String
    
    var body: some View {
        let VDLink = "https://apps.apple.com/tr/app/vaydosh/id6450205976"
        let privacyPolicy = "https://docs.google.com/" +
        "document/d/1Acw-XZaRoO3vw2FTcwhijHmMtpGtizYuoVYRyVPGaVE"
        List {
            VStack(alignment: .leading) {
                Text("VayDosh".localized(language))
                    .fontWeight(.bold)
                HStack {
                    Text("Version:".localized(language))
                    Text(appVersion!)
                }
                .font(.footnote)
                .foregroundColor(.secondary)
                HStack {
                    Text("© MZA".localized(language))
                    Spacer()
                    Text("2024")
                }
            }
            Section(content: {
                Link(destination: URL(string: "https://ghalghay.github.io/")!) {
                    HStack{
                        Text("Set of Ingush Dictionaries".localized(language))
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                }
            }, header: {
                HStack {
                    Image(systemName: "archivebox")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 25)
                        .foregroundColor(.accentColor)
                    Text("Reference".localized(language))
                }
            })
            Section(content: {
                Link(destination: URL(string: "https://lottiefiles.com/")!) {
                    HStack{
                        Text("Lottie Animations".localized(language))
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                }
                .listRowSeparator(.hidden)
                Link(destination: URL(string: "https://www.flaticon.com/")!) {
                    HStack{
                        Text("Icon made by Freepik from Flaticon".localized(
                            language))
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                }
            }, header: {
                HStack {
                    Image(systemName: "paintpalette")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 25)
                        .foregroundColor(.accentColor)
                    Text("Graphic Materials".localized(language))
                }
            })
            Section(content: {
                Link(destination: URL(string: privacyPolicy)!) {
                    HStack{
                        Text("Privacy Policy".localized(language))
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                }
            })
        } // List
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                VStack {
                    Button {
                        shareText = ShareText(text:
                                                "VayDosh: ".localized(language)
                                              + VDLink)
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    
                }
                .sheet(item: $shareText) { shareText in
                    ActivityView(text: shareText.text)
                }
                
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
