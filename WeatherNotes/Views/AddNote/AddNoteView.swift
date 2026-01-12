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

    var body: some View {
        VStack(spacing: 16) {
            TextField("Enter note", text: $viewModel.text)
                .textFieldStyle(.roundedBorder)

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }

            if viewModel.isLoading {
                ProgressView()
            }

            Button("Save") {
                Task {
                    await viewModel.saveNote()
                    if viewModel.errorMessage == nil {
                        dismiss()
                    }
                }
            }
            .disabled(viewModel.text.trimmingCharacters(in: .whitespaces).isEmpty || viewModel.isLoading)
        }
        .padding()
    }
}

#Preview {
    AddNoteView()
}
