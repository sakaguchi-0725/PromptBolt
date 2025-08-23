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

final class SettingsManager: ObservableObject {
    @AppStorage("launchOnStart") var launchOnStart = false
    @AppStorage("autoUpdateCheck") var autoUpdateCheck = true
    
    static let shared = SettingsManager()
    
    private init() {}
}
