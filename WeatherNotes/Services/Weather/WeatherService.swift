//
//  WeatherService.swift
//  WeatherNotes
//
//  Created by Vladyslav Behim on 13.01.2026.
//

import Foundation

final class WeatherService {

    private let apiKey = "5e974869cf535e6ea9ed40b3c22e5267"
    private let city = "Kyiv"

    func fetchWeather() async throws -> Weather {

        let urlString =
        "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)"

        guard let url = URL(string: urlString) else {
            throw WeatherError.invalidURL
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode else {
                throw WeatherError.invalidResponse
            }

            let decoded = try JSONDecoder().decode(WeatherResponse.self, from: data)

            return Weather(
                temperature: decoded.main.temp - 273.15,
                description: decoded.weather.first?.description ?? "—",
                icon: decoded.weather.first?.icon ?? "",
                location: decoded.name
            )

        } catch let decodingError as DecodingError {
            throw WeatherError.decodingError
        } catch {
            throw WeatherError.network(error)
        }
    }
}
