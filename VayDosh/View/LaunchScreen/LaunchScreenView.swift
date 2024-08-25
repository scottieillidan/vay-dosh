//
//  LaunchScreen.swift
//  VayDosh
//
//  Created by Adam Miziev on 5/22/23.
//

import SwiftUI

struct LaunchScreenView: View {
    @State private var isActive = false
    @State private var size = 0.5
    @State private var opacity = 0.2
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            Image("Emblem")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 350, height: 350)
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.55)) {
                        self.size = 1.0
                        self.opacity = 1.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
        }
    }
}
