//
//  NoteRowView.swift
//  WeatherNotes
//
//  Created by Vladyslav Behim on 13.01.2026.
//

import SwiftUI

struct NoteRowView: View {
    
    let note: CDNote
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: note.dateAndTime)
    }
    
    private var temperatureText: String {
        String(format: "%.1f℃", note.temperature)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(note.title)
                    .font(.headline)
                Text(formattedDate)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(spacing: 4) {
                Text(temperatureText)
                    .font(.subheadline)
                
                if let url = URL(string: "https://openweathermap.org/img/wn/\(note.icon)@2x.png") {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 40, height: 40)

                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)

                        case .failure:
                            Image(systemName: "network.slash")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32)
                                .foregroundColor(.red)
                        
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
            }
        }
        .padding(.vertical, 8)
    }
}

