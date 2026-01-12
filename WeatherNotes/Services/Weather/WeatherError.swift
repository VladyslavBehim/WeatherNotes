//
//  WeatherError.swift
//  WeatherNotes
//
//  Created by Vladyslav Behim on 13.01.2026.
//

import Foundation

enum WeatherError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    case network(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid weather service URL"
        case .invalidResponse:
            return "Invalid server response"
        case .decodingError:
            return "Failed to decode weather data"
        case .network(let error):
            return error.localizedDescription
        }
    }
}
