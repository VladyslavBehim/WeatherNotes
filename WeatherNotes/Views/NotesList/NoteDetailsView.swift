//
//  NoteDetailsView.swift
//  WeatherNotes
//
//  Created by Vladyslav Behim on 13.01.2026.
//

import SwiftUI

struct NoteDetailsView: View {
    let note: CDNote
    
    private var formattedDate: String {
        let df = DateFormatter()
        df.dateStyle = .long
        df.timeStyle = .none
        return df.string(from: note.dateAndTime)
    }
    
    private var formattedTime: String {
        let df = DateFormatter()
        df.dateStyle = .none
        df.timeStyle = .short
        return df.string(from: note.dateAndTime)
    }
    
    private var temperatureText: String {
        String(format: "%.1f℃", note.temperature)
    }
    @State private var isShowingDetails: Bool = false
    @State private var isShowingDeletionAlert: Bool = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    HStack{
                        Text(note.title)
                            .font(.largeTitle.bold())
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)

                        Spacer()
                        HStack{
                            Button(role:.destructive){
                                isShowingDeletionAlert.toggle()
                            } label: {
                                Image(systemName: "trash")
                                    .padding(.horizontal)
                                    .padding(.vertical , 8)
                                    .background(Color.red.opacity(0.25))
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            }

                            Button {
                                withAnimation(.snappy) {
                                    isShowingDetails.toggle()
                                }
                            } label: {
                                HStack{
                                    Text(!isShowingDetails ? "Show more details" : "Hide details")
                                }
                                .padding(.horizontal)
                                .padding(.vertical , 8)
                                .background(!isShowingDetails ? Color.blue.opacity(0.25) : Color.blue.opacity(0.45))
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .contentTransition(.numericText())
                            }
                        }
                        .font(.subheadline)
                    }
                    
                    
                    HStack(spacing: 8) {
                        Label(formattedDate, systemImage: "calendar")
                        Text("•")
                        Label(formattedTime, systemImage: "clock")
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 16) {
                    HStack(spacing: 12) {
                        if let url = URL(string: "https://openweathermap.org/img/wn/\(note.icon)@2x.png") {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: 64, height: 64)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 64, height: 64)
                                case .failure:
                                    Image(systemName: "network.slash")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                        .foregroundStyle(.red)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Text(temperatureText)
                                    .font(.title2.bold())
                                Text(note.weatherDescription.capitalized)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            
                            HStack(spacing: 8) {
                                Label(note.location, systemImage: "mappin.and.ellipse")
                                    .lineLimit(1)
                                Spacer()
                            }
                            .font(.subheadline)
                            .foregroundStyle(.primary)
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .background(.blue.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                
                VStack(alignment: .center, spacing: 8) {
                    
                    if isShowingDetails{
                        HStack(spacing: 10) {
                            Label(temperatureText, systemImage: "thermometer.sun")
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(.orange.opacity(0.15))
                                .foregroundStyle(.orange)
                                .clipShape(Capsule())
                            
                            Label(note.weatherDescription.capitalized, systemImage: "cloud.sun")
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(.teal.opacity(0.15))
                                .foregroundStyle(.teal)
                                .clipShape(Capsule())
                            
                        }
                        .transition(.move(edge: .bottom).combined(with: .blurReplace))
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding()
            .alert(isPresented: $isShowingDeletionAlert) {
                Alert(
                    title: Text("Delete Note"),
                    message: Text("Are you sure you want to delete this note?"),
                    primaryButton: .cancel(),
                    secondaryButton: .destructive(Text("Remove"), action: {
                        dismiss()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            CDNote.delete(note: self.note)
                        }
                    }))
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
