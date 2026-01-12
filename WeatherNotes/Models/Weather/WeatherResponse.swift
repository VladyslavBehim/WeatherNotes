//
//  WeatherResponse.swift
//  WeatherNotes
//
//  Created by Vladyslav Behim on 13.01.2026.
//

import Foundation

struct WeatherResponse: Decodable {
    let name: String
    let main: Main
    let weather: [WeatherItem]

    struct Main: Decodable {
        let temp: Double
        let feelsLike: Double

        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
        }
    }

    struct WeatherItem: Decodable {
        let description: String
        let icon: String
    }
}
