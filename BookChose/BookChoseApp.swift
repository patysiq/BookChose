//
//  BookChoseApp.swift
//  BookChose
//
//  Created by PATRICIA S SIQUEIRA on 26/02/21.
//

import SwiftUI

@main
struct BookChoseApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
