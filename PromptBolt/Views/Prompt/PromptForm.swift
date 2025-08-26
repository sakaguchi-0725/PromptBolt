//
//  PromptForm.swift
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

struct PromptForm: View {
    @Binding var title: String
    @Binding var content: String
    @Binding var shortcutKey: ShortcutKey?
    let errorMessage: String?
    
    var body: some View {
        VStack(spacing: 20) {
            TextInputField(label: "Title", placeholder: "Prompt title", input: $title)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Shortcut Key")
                    .font(.headline)
                
                ShortcutKeyInputField(shortcutKey: $shortcutKey)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Content")
                    .font(.headline)
                TextEditor(text: $content)
                    .frame(height: 250)
                    .scrollIndicators(.never)
                    .scrollContentBackground(.hidden)
                    .padding(8)
                    .background(Color(NSColor.windowBackgroundColor))
                    .cornerRadius(4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(.separator, lineWidth: 1)
                    )
            }
            
            if let errorMessage = errorMessage {
                ErrorMessage(message: errorMessage)
            }
        }
    }
}
