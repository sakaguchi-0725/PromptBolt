//
//  CreatePromptView.swift
//
//  PromptBolt
//  GitHub: https://github.com/sakaguchi-0725/PromptBolt
//
//  Created by Kazuma Sakaguchi on 2025/08/25.
//
//  Copyright © 2025 Kazuma Sakaguchi.
//  Licensed under the MIT License.
//

import SwiftUI

struct CreatePromptView: View {
    @Environment(PromptState.self) private var promptState
    @Environment(\.dismiss) private var dismiss
    @State var title = ""
    @State var content = ""
    @State var shortcutKey: ShortcutKey?
    @State private var errorMessage: String?
    
    var body: some View {
        ScrollView {
            PromptForm(
                title: $title,
                content: $content,
                shortcutKey: $shortcutKey,
                errorMessage: errorMessage
            ).padding(.bottom, 10)
            
            FormActionButtons(
                onCancel: { dismiss() },
                onSubmit: { createPrompt() },
                submitTitle: "Create"
            )
        }
        .scrollIndicators(.never)
        .padding()
    }
    
    private func createPrompt() {
        do {
            let prompt = try Prompt(
                title: title,
                content: content,
                shortcutKey: shortcutKey
            )
            try promptState.addPrompt(prompt)
            dismiss()
        } catch {
            handleError(error)
        }
    }
    
    private func handleError(_ error: Error) {
        switch error {
        case let promptError as PromptError:
            errorMessage = promptError.localizedDescription
        case let shortcutError as ShortcutError:
            errorMessage = shortcutError.localizedDescription
        case is DecodingError:
            errorMessage = "Data format error occurred"
        default:
            errorMessage = "An unexpected error occurred: \(error.localizedDescription)"
        }
    }
}

#Preview {
    CreatePromptView()
        .environment(PromptState(context: DataManager.previewContainer().mainContext))
}
