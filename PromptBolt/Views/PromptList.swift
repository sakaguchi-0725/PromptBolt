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
    @State var path = NavigationPath()
    @State var searchText = ""
    
    enum PromptPath: Hashable {
        case create
        case edit(Prompt)
    }
    
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
        NavigationStack(path: $path) {
            VStack {
                HStack(spacing: 2) {
                    TextInputField(placeholder: "Search prompts", input: $searchText)
                    
                    Spacer()
                    
                    Button {
                        path.append(PromptPath.create)
                    } label: {
                        Text("New")
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                    }.buttonStyle(.primary)
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
                                PromptListItem(prompt: prompt) {
                                    path.append(PromptPath.edit(prompt))
                                }
                            }
                        }
                    }
                    .scrollIndicators(.never)
                }
            }
        }
        .navigationDestination(for: PromptPath.self) { destination in
            switch destination {
            case .create:
                CreatePrompt()
            case .edit(let prompt):
                EditPrompt(prompt: prompt)
            }
        }
    }
}

// MARK: - PromptListItem
struct PromptListItem: View {
    let prompt: Prompt
    let onTap: () -> Void
    
    var body: some View {
        // TODO: タップ可能なCardにして、PromptPath.edit(prompt)を設定
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
        .onTapGesture {
            onTap()
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
