//
//  ShareSheet.swift
//  VayDosh
//
//  Created by Adam Miziev on 8/26/24.
//

import SwiftUI
import UIKit

struct ShareSheet: UIViewControllerRepresentable {
    let text: String
    
    func makeUIViewController(context:
                              UIViewControllerRepresentableContext
                              <ShareSheet>)
    -> UIActivityViewController {
        return UIActivityViewController(activityItems: [text],
                                        applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController,
                                context:
                                UIViewControllerRepresentableContext
                                <ShareSheet>) {}
}

struct ShareText: Identifiable {
    let id = UUID()
    let text: String
}
