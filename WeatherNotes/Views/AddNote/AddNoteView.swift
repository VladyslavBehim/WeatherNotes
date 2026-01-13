//
//  AddNoteView.swift
//  WeatherNotes
//
//  Created by Vladyslav Behim on 13.01.2026.
//

import SwiftUI

struct AddNoteView: View {
    @StateObject private var viewModel = AddNoteViewModel()
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isFieldFocused: Bool

    private var isSaveDisabled: Bool {
        viewModel.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || viewModel.isLoading
    }

    var body: some View {
        NavigationView {
                VStack(spacing: 20) {
                    Text("📝")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.blue.opacity(0.4))
                        .clipShape(Circle())
                    VStack(alignment: .leading, spacing: 12) {
                        Text("New Note")
                            .font(.title2.bold())

                        VStack(alignment: .leading, spacing: 10) {
                            TextField("Enter note", text: $viewModel.text)
                                .focused($isFieldFocused)
                                .padding(12)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(isFieldFocused ? Color.blue.opacity(0.4) : Color.secondary.opacity(0.15), lineWidth: 1)
                                )
                            if let error = viewModel.errorMessage, !error.isEmpty {
                                HStack(spacing: 8) {
                                    Image(systemName: "exclamationmark.circle")
                                    Text(error)
                                }
                                .font(.footnote)
                                .foregroundColor(.red)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color.red.opacity(0.08))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                    }
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    Spacer()
                    Button(action: save) {
                        HStack {
                            if viewModel.isLoading {
                                ProgressView()
                                    .tint(.white)
                            }
                            Text("Save")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(isSaveDisabled ? Color.accentColor.opacity(0.4) : Color.accentColor)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    .disabled(isSaveDisabled)
                }
                .padding()
            
            .navigationTitle("Add Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    isFieldFocused = true
                }
            }
        }
    }

    private func save() {
        Task {
            await viewModel.saveNote()
            if viewModel.errorMessage == nil {
                dismiss()
            }
        }
    }
}

#Preview {
    AddNoteView()
}
