//
//  SettingsManager.swift
//
//  PromptBolt
//  GitHub: https://github.com/sakaguchi-0725/PromptBolt
//
//  Created by Kazuma Sakaguchi on 2025/08/24.
//
//  Copyright © 2025 Kazuma Sakaguchi.
//  Licensed under the MIT License.
//

import SwiftUI
import Combine
import ServiceManagement

final class SettingsManager: ObservableObject {
    @AppStorage("launchOnStart") var launchOnStart = false {
        didSet { updateLaunchOnStart() }
    }
    @AppStorage("autoUpdateCheck") var autoUpdateCheck = true
    
    private func updateLaunchOnStart() {
        if launchOnStart {
            try? SMAppService.mainApp.register()
        } else {
            try? SMAppService.mainApp.unregister()
        }
    }
    
    static let shared = SettingsManager()
    
    private init() {}
}
