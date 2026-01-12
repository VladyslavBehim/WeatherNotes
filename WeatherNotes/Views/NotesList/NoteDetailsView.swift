//
//  NoteDetailsView.swift
//  WeatherNotes
//
//  Created by Vladyslav Behim on 13.01.2026.
//

import SwiftUI

struct NoteDetailsView: View {
    let note: CDNote
    
    var body: some View {
        VStack(spacing: 16) {
            Text(note.title)
                .font(.title)
            
            Text(note.dateAndTime, style: .date)
            Text(note.dateAndTime, style: .time)
            
            Text(String(format: "%.1f℃", note.temperature))
            Text(note.weatherDescription)
            
            if let url = URL(string: "https://openweathermap.org/img/wn/\(note.icon)@2x.png") {
                AsyncImage(url: url) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
            }
            
            Text(note.location)
        }
        .padding()
    }
}

