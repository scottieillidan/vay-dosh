//
//  ShareSheetActivity.swift
//  VayDosh
//
//  Created by Adam Miziev on 7/17/23.
//

import SwiftUI
import UIKit

struct ActivityView: UIViewControllerRepresentable {
    let text: String
    
    func makeUIViewController(context: 
                              UIViewControllerRepresentableContext
                              <ActivityView>)
    -> UIActivityViewController {
        return UIActivityViewController(activityItems: [text], 
                                        applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, 
                                context:
                                UIViewControllerRepresentableContext
                                <ActivityView>) {}
}

struct ShareText: Identifiable {
    let id = UUID()
    let text: String
}
