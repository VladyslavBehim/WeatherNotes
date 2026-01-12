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
    @State private var isShowingAddNote: Bool = false
    var body: some View {
        NavigationView {
            List {
                ForEach(notes) { note in
                    NavigationLink(destination: NoteDetailsView(note: note)) {
                        NoteRowView(note: note)
                            .contextMenu {
                                Button(role: .destructive){
                                    withAnimation(.default) {
                                        CDNote.delete(note: note)
                                    }
                                } label: {
                                    Label {
                                        Text("Remove")
                                    } icon: {
                                        Image(systemName: "trash")
                                    }

                                }

                            }
                    }
                }
            }
            .sheet(isPresented: $isShowingAddNote, content: {
                AddNoteView()
                    
            })
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Weather Notes")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingAddNote.toggle()
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
