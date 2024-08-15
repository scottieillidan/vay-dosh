//
//  VayDoshApp.swift
//  VayDosh
//
//  Created by Adam Miziev on 5/2/23.
//

import SwiftUI

@main
struct VayDoshApp: App {
    @AppStorage("displayMode") var displayMode = DisplayMode.system
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LaunchScreenView()
                .environment(\.managedObjectContext, 
                              persistenceController.container.viewContext)
                .onAppear {
                    displayMode.setAppDisplayMode()
                }
        }
    }
}

