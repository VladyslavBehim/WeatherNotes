//
//  WeatherNotesApp.swift
//  WeatherNotes
//
//  Created by Vladyslav Behim on 12.01.2026.
//

import SwiftUI
import CoreData

@main
struct WeatherNotesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NotesListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
