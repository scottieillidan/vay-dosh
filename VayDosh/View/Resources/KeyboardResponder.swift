//
//  KeyboardResponder.swift
//  VayDosh
//
//  Created by Adam Miziev on 8/24/24.
//

import SwiftUI
import Combine

class KeyboardResponder: ObservableObject {
    @Published var isKeyboardVisible: Bool = false
    private var cancellable: AnyCancellable?

    init() {
        cancellable = NotificationCenter.default.publisher(
            for: UIResponder.keyboardWillShowNotification)
            .merge(with: NotificationCenter.default.publisher(
                for: UIResponder.keyboardWillHideNotification))
            .sink { notification in
                withAnimation {
                    self.isKeyboardVisible = 
                    notification.name == UIResponder.keyboardWillShowNotification
                }
            }
    }

    deinit {
        cancellable?.cancel()
    }
}
