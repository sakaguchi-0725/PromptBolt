//
//  Prompt.swift
//
//  PromptBolt
//  GitHub: https://github.com/sakaguchi-0725/PromptBolt
//
//  Created by Kazuma Sakaguchi on 2025/08/21.
//
//  Copyright © 2025 Kazuma Sakaguchi.
//  Licensed under the MIT License.
//

import Foundation
import SwiftData

@Model
final class Prompt {
    var id: UUID
    var title: String
    var content: String
    var shortcutKey: ShortcutKey?
    var createdAt: Date
    
    init(title: String, content: String, shortcutKey: ShortcutKey? = nil) {
        self.id = UUID()
        self.title = title
        self.content = content
        self.shortcutKey = shortcutKey
        self.createdAt = Date()
    }
}
