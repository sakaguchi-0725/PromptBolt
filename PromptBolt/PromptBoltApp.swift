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
    let dataManager = DataManager.shared.production

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(dataManager)
    }
}
