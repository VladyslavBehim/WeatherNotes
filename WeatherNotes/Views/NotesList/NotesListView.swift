//
//  NotesListView.swift
//  WeatherNotes
//
//  Created by Vladyslav Behim on 13.01.2026.
//

import SwiftUI
import CoreData

struct NotesListView: View {
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CDNote.dateAndTime_, ascending: false)],
        animation: .default
    )
    private var notes: FetchedResults<CDNote>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(notes) { note in
                    NavigationLink(destination: NoteDetailsView(note: note)) {
                        NoteRowView(note: note)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Weather Notes")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Text("Add Note")
                    }

                }
            }
            .listStyle(.insetGrouped)
        }
    }
}

#Preview {
    NotesListView()
}
