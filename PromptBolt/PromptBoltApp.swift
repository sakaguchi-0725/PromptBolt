//
//  PromptBoltApp.swift
//
//  PromptBolt
//  GitHub: https://github.com/sakaguchi-0725/PromptBolt
//
//  Created by Kazuma Sakaguchi on 2025/08/21.
//
//  Copyright © 2025 Kazuma Sakaguchi.
//  Licensed under the MIT License.
//

import SwiftUI
import SwiftData

@main
struct PromptBoltApp: App {
    private let container: ModelContainer
    private let promptState: PromptState
    
    init() {
        self.container = DataManager.shared.production
        self.promptState = .init(context: self.container.mainContext)
    }

    var body: some Scene {
        MenuBarExtra {
            MenuBarView()
                .environment(promptState)
        } label: {
            Image("MenuBarIcon")
                .renderingMode(.template)
        }
        .menuBarExtraStyle(.window)
        
        Window("Dashboard", id: "dashboard") {
            DashboardView()
                .environment(promptState)
        }
        .modelContainer(container)
        .windowResizability(.contentSize)
    }
}
