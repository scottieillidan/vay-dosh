//
//  AppearanceSectionView.swift
//  VayDosh
//
//  Created by Adam Miziev on 8/31/24.
//

import SwiftUI

struct AppearanceSectionView: View {
    @Binding var displayMode: DisplayMode
    var body: some View {
        Section {
            HStack {
                CustomText(text: "Icon", size: 17)
                Spacer()
                IconPicker()
            }
            HStack {
                CustomText(text: "Color Scheme:", size: 17)
                Picker("Is Dark?", selection: $displayMode) {
                    CustomText(text: "Auto")
                        .tag(DisplayMode.system)
                    CustomText(text: "Dark")
                        .tag(DisplayMode.dark)
                    CustomText(text: "Light")
                        .tag(DisplayMode.light)
                }
                .pickerStyle(.segmented)
                .onChange(of: displayMode) { newValue in
                    displayMode.setAppDisplayMode()
                }
                .padding(.trailing, -10)
            }
            .listRowSeparator(.hidden)
        } header: {
            SectionHeaderView(icon: "paintbrush", section: "Appearance")
        }
    }
}
