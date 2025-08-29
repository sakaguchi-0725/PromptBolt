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
import AppKit
import SwiftData

struct MenuBarView: View {
    @Environment(PromptState.self) private var promptState
    @Environment(\.openWindow) private var openWindow
    @StateObject private var updateManager: UpdateManager = .shared
    
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
                .padding(.horizontal, -10)
                .padding(.vertical, 6)
            
            Button {
                activateOrOpenDashboard()
            } label: {
                Text("Dashboard")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 8)
            }.buttonStyle(.secondary)
            
            Button {
                updateManager.checkForUpdates()
            } label: {
                Text("Check for updates...")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 8)
            }.buttonStyle(.secondary)
            
            Button {
                NSApplication.shared.terminate(nil)
            } label: {
                Text("Quit")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 8)
            }.buttonStyle(.secondary)
        }
        .padding(10)
        .frame(maxWidth: 200)
    }
    
    private func activateOrOpenDashboard() {
        if let dashboardWindow = NSApp.windows.first(where: { window in
            return window.identifier?.rawValue == "dashboard"
        }) {
            dashboardWindow.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
        } else {
            openWindow(id: "dashboard")
            NSApp.activate(ignoringOtherApps: true)
        }
    }
}

#Preview {
    MenuBarView()
        .environment(PromptState(context: DataManager.previewContainer().mainContext))
}
