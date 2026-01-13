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
            VStack{
                if notes.isEmpty{
                    VStack(spacing: 20){
                        Text("Welcome to Weather Notes")
                            .font(.title)
                        HStack{
                            Text("Add your first note")
                                .fontWeight(.semibold)
                            Button {
                                isShowingAddNote.toggle()
                            } label: {
                                Text("Add note 📝")
                                    .padding(.horizontal)
                                    .padding(.vertical , 8)
                                    .background(Color.blue.opacity(0.25))
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .foregroundStyle(Color.blue)
                                
                            }

                        }
                    }
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }else{
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
                    
                    .listStyle(.insetGrouped)
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
        }
    }
}

#Preview {
    NotesListView()
}
