//
//  PromptView.swift
//
//  PromptBolt
//  GitHub: https://github.com/sakaguchi-0725/PromptBolt
//
//  Created by Kazuma Sakaguchi on 2025/08/23.
//
//  Copyright © 2025 Kazuma Sakaguchi.
//  Licensed under the MIT License.
//

import SwiftUI

// MARK: - PromptList
struct PromptList: View {
    @Environment(PromptState.self) var promptState
    @State var searchText = ""
    
    private var filterdPrompts: [Prompt] {
        if searchText.isEmpty {
            return promptState.prompts
        } else  {
            return promptState.prompts.filter { prompt in
                prompt.title.localizedCaseInsensitiveContains(searchText) ||
                prompt.content.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 2) {
                TextInputField(placeholder: "Search prompts", input: $searchText)
                
                Spacer()
                
                // TODO: implements action
                PrimaryButton(label: "New", action: {})
                    .frame(width: 60, height: 33)
            }.padding(.bottom)
            
            if filterdPrompts.isEmpty {
                VStack(spacing: 8) {
                    Image(systemName: "doc.text")
                        .font(.largeTitle)
                        .foregroundStyle(.secondary)
                    Text(searchText.isEmpty ? "No prompts available" : "No matching prompts found")
                        .bold()
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(filterdPrompts) { prompt in
                            PromptListItem(prompt: prompt)
                        }
                    }
                }
                .scrollIndicators(.never)
            }
        }
    }
}

// MARK: - PromptListItem
struct PromptListItem: View {
    let prompt: Prompt
    
    var body: some View {
        Card {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(prompt.title)
                        .font(.headline)
                    
                    Spacer()
                }
                
                Text(prompt.content)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)
                    .frame(height: 50, alignment: .top)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    VStack {
        PromptList()
            .environment(PromptState(context: DataManager.previewContainer().mainContext))
    }.padding()
}
