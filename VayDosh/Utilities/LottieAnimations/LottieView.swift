//
//  LottieView.swift
//  VayDosh
//
//  Created by Adam Miziev on 4/30/24.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let loopMode: LottieLoopMode
    var animationName: String
    
    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: animationName)
        animationView.play()
        animationView.loopMode = loopMode
        animationView.contentMode = .scaleAspectFit
        return animationView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
