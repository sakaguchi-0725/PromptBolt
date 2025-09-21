//
//  SettingsState.swift
//
//  PromptBolt
//  GitHub: https://github.com/sakaguchi-0725/PromptBolt
//
//  Created by Kazuma Sakaguchi on 2025/09/19.
//
//  Copyright © 2025 Kazuma Sakaguchi.
//  Licensed under the MIT License.
//

import Foundation

@Observable
final class SettingsState {
    private(set) var currentVersion: String
    private(set) var isUpdateAvailable: Bool = false
    
    var launchOnStart: Bool {
        get { settingsManager.launchOnStart }
        set { settingsManager.launchOnStart = newValue }
    }
    
    var autoUpdateCheck: Bool {
        get { settingsManager.autoUpdateCheck }
        set {
            settingsManager.autoUpdateCheck = newValue
            updateService.autoUpdateEnabled = newValue
        }
    }
    
    private var settingsManager: SettingsManager
    private var updateService: UpdateService
    
    init(settingsManager: SettingsManager = .shared, updateService: UpdateService) {
        self.currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        self.settingsManager = settingsManager
        self.updateService = updateService
        
        self.updateService.setUpdateAvailable = { [weak self] available in
            Task { @MainActor in
                self?.isUpdateAvailable = available
            }
        }
    }
    
    func checkForUpdates() {
        self.updateService.checkForUpdates()
    }
}
