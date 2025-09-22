//
//  PromptListView.swift
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
struct PromptListView: View {
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
                CreatePromptView()
            case .edit(let prompt):
                EditPromptView(prompt: prompt)
            }
        }
    }
}

// MARK: - PromptListItem
struct PromptListItem: View {
    let prompt: Prompt
    let onTap: () -> Void
    @State private var isHovered = false
    
    var body: some View {
        Card {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(prompt.title)
                        .font(.headline)
                    
                    Text(prompt.shortcutKey.displayString)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 3)
                        .background(Color(.quaternarySystemFill))
                        .foregroundColor(.primary)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color(.separatorColor), lineWidth: 0.5)
                        )
                    
                    Spacer()
                }
                
                Text(prompt.content)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)
                    .frame(height: 50, alignment: .top)
            }
        }
        .scaleEffect(isHovered ? 1.00 : 0.99)
        .shadow(
            color: .black.opacity(isHovered ? 0.15 : 0.05),
            radius: isHovered ? 8 : 4,
            x: 0,
            y: isHovered ? 4 : 2
        )
        .animation(.easeOut(duration: 0.2), value: isHovered)
        .contentShape(Rectangle())
        .onHover { hovering in
            isHovered = hovering
        }
        .onTapGesture {
            onTap()
        }
    }
}

// MARK: - Preview
#Preview {
    VStack {
        PromptListView()
            .environment(PromptState(context: DataManager.previewContainer().mainContext))
    }.padding()
}
