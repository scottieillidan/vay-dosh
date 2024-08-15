//
//  LaunchScreen.swift
//  VayDosh
//
//  Created by Adam Miziev on 5/22/23.
//

import SwiftUI

struct LaunchScreenView: View {
    @AppStorage("language") private var language = 
    LocalizationService.shared.language
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack(spacing: -60.0) {
                Image("Emblem")
                    .resizable()
                    .interpolation(.high)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 350)
                Text("VayDosh".localized(language))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 3)
            }
            .scaleEffect(size)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.55)) {
                    self.size = 1.0
                    self.opacity = 1.0
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
