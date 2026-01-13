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
        VStack {
            HStack{
                Text(note.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                Spacer()
                Text(formattedDate)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            HStack{
                Text("Weather conditions")
                    .font(.subheadline)
                Spacer()
                HStack{
                    Text(temperatureText)
                        .fontWeight(.semibold)
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
                .fontWeight(.semibold)
                .font(.footnote)
                .padding(.horizontal)
                .background(.blue.opacity(0.15))
                .foregroundColor(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }

        }
        .padding(.vertical, 5)
    }
}

