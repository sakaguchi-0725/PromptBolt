//
//  EditPromptView.swift
//
//  PromptBolt
//  GitHub: https://github.com/sakaguchi-0725/PromptBolt
//
//  Created by Kazuma Sakaguchi on 2025/08/26.
//
//  Copyright © 2025 Kazuma Sakaguchi.
//  Licensed under the MIT License.
// 

import SwiftUI

struct EditPromptView: View {
    @Environment(PromptState.self) private var promptState
    @Environment(\.dismiss) private var dismiss
    @State private var title: String
    @State private var content: String
    @State private var shortcutKey: ShortcutKey?
    @State private var errorMessage: String?
    
    let prompt: Prompt
    
    init(prompt: Prompt) {
        self.prompt = prompt
        self._title = .init(initialValue: prompt.title)
        self._content = .init(initialValue: prompt.content)
        self._shortcutKey = .init(initialValue: prompt.shortcutKey)
    }
    
    var body: some View {
        ScrollView {
            PromptForm(
                title: $title,
                content: $content,
                shortcutKey: $shortcutKey,
                errorMessage: errorMessage,
            ).padding(.bottom, 20)
            
            FormActionButtons(
                onCancel: { dismiss() },
                onSubmit: { updatePrompt() },
                submitTitle: "Update"
            )
        }
        .scrollIndicators(.never)
        .padding()
    }
    
    private func updatePrompt() {
        do {
            if title != prompt.title {
                try prompt.updateTitle(title)
            }
            
            if content != prompt.content {
                try prompt.updateContent(content)
            }
            
            if shortcutKey != prompt.shortcutKey {
                try prompt.updateShortcutKey(shortcutKey)
            }
            
            try promptState.updatePrompt(prompt)
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
    let prompt = try! Prompt(
        title: "Long Sample",
        content: "This is a very long sample text that demonstrates how the preview looks with longer content.",
        shortcutKey: ShortcutKey(
            modifierKeys: [ModifierKey.command.rawValue, ModifierKey.option.rawValue],
            mainKey: CharacterKey.p.rawValue
        )
    )
    
    EditPromptView(prompt: prompt)
        .environment(PromptState(context: DataManager.previewContainer().mainContext))
}
