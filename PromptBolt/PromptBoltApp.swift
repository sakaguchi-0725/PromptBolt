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
    private var container: ModelContainer
    private let promptState: PromptState
    private let settingsState: SettingsState
    
    init() {
        self.container = DataManager.shared.production
        let settingsManager = SettingsManager.shared
        let notificationService = NotificationService()
        let updateService = UpdateService(
            autoUpdateEnabled: settingsManager.autoUpdateCheck,
            notificationService: notificationService
        )
        
        self.promptState = .init(context: self.container.mainContext)
        self.settingsState = .init(settingsManager: settingsManager, updateService: updateService)
    }

    var body: some Scene {
        MenuBarExtra {
            MenuBarView()
                .environment(promptState)
                .environment(settingsState)
        } label: {
            Image("MenuBarIcon")
                .renderingMode(.template)
        }
        .menuBarExtraStyle(.window)
        
        Window("Dashboard", id: "dashboard") {
            DashboardView()
                .environment(promptState)
                .environment(settingsState)
        }
        .modelContainer(container)
        .windowResizability(.contentSize)
    }
}
