//
//  DashboardView.swift
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

struct DashboardView: View {
    @State private var selectedItem: SidebarItem? = .general
    
    enum SidebarItem: String, CaseIterable, Identifiable {
        case general = "General"
        case prompts = "Prompts"
        case settings = "Settings"
        
        var id: String { self.rawValue }
    }
    
    var body: some View {
        NavigationSplitView {
            List(SidebarItem.allCases, selection: $selectedItem) { item in
                Text(item.rawValue)
                    .tag(item)
            }
        } detail: {
            Group {
                switch selectedItem {
                case .general:
                    General()
                case .prompts:
                    PromptList()
                case .settings:
                    Text("Settings")
                case .none:
                    EmptyView()
                }
            }
            .navigationTitle(selectedItem?.rawValue ?? "")
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding()
        }
    }
}

#Preview {
    let promptState = PromptState(context: DataManager.previewContainer().mainContext)
    
    DashboardView()
        .environment(promptState)
}
