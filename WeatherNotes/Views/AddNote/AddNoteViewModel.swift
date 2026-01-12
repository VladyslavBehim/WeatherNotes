//
//  AddNoteViewModel.swift
//  WeatherNotes
//
//  Created by Vladyslav Behim on 13.01.2026.
//

import Foundation
import CoreData
import Combine

@MainActor
final class AddNoteViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let weatherService = WeatherService()
    private let context = PersistenceController.shared.container.viewContext

    func saveNote() async {
        let trimmed = text.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else {
            errorMessage = "Note text cannot be empty"
            return
        }

        isLoading = true
        errorMessage = nil
        
        do {
            let weather = try await weatherService.fetchWeather()

            let note = CDNote(context: context)
            note.id = UUID()
            note.title = trimmed
            note.dateAndTime = Date()
            note.temperature = weather.temperature
            note.location = weather.location
            note.weatherDescription = weather.description
            note.icon = weather.icon

            try context.save()
            
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
