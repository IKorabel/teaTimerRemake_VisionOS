//
//  TeaTimerRemakeV2App.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 07.03.24.
//

import SwiftUI
import SwiftData

@main
struct TeaTimerRemakeV2App: App {
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
