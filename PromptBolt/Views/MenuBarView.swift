//
//  MenuBarView.swift
//
//  PromptBolt
//  GitHub: https://github.com/sakaguchi-0725/PromptBolt
//
//  Created by Kazuma Sakaguchi on 2025/08/22.
//
//  Copyright © 2025 Kazuma Sakaguchi.
//  Licensed under the MIT License.
//

import SwiftUI
import SwiftData

struct MenuBarView: View {
    @Environment(PromptState.self) private var promptState
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            if promptState.prompts.isEmpty {
                Text("No prompts available")
                    .foregroundColor(Color(.secondaryLabelColor))
                    .padding(.vertical, 6)
                    .padding(.horizontal, 8)
            } else {
                ForEach(promptState.prompts.prefix(5)) { prompt in
                    HStack {
                        Text(prompt.title)
                        Spacer()
                        Text(prompt.shortcutKey.displayString)
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 8)
                }
            }
            
            Divider()
                .padding(.vertical, 6)
            
            // TODO
            SecondaryButton(label: "Dashboard", action: {})
            
            SecondaryButton(label: "Quit") {
                NSApplication.shared.terminate(nil)
            }
        }
    }
}

#Preview {
    MenuBarView()
        .environment(PromptState(context: DataManager.previewContainer().mainContext))
}
