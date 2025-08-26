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

enum PromptError: LocalizedError {
    case required(field: String)
    
    var errorDescription: String? {
        switch self {
        case .required(let field):
            return "\(field) is required"
        }
    }
}

@Model
final class Prompt {
    var id: UUID
    var title: String
    var content: String
    var shortcutKey: ShortcutKey
    var createdAt: Date
    
    init(title: String, content: String, shortcutKey: ShortcutKey?) throws {
        try Self.validateTitle(title)
        try Self.validateContent(content)
        try Self.validateShortcutKey(shortcutKey)
        
        self.id = UUID()
        self.title = title
        self.content = content
        self.shortcutKey = shortcutKey!
        self.createdAt = Date()
    }
    
    func updateTitle(_ newTitle: String) throws {
        try Self.validateTitle(newTitle)
        self.title = newTitle
    }
    
    func updateContent(_ newContent: String) throws {
        try Self.validateContent(newContent)
        self.content = newContent
    }
    
    func updateShortcutKey(_ newShortcutKey: ShortcutKey?) throws {
        try Self.validateShortcutKey(newShortcutKey)
        self.shortcutKey = newShortcutKey!
    }
    
    private static func validateTitle(_ title: String) throws {
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw PromptError.required(field: "Title")
        }
    }
    
    private static func validateContent(_ content: String) throws {
        if content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw PromptError.required(field: "Content")
        }
    }
    
    private static func validateShortcutKey(_ shortcutKey: ShortcutKey?) throws {
        if shortcutKey == nil {
            throw PromptError.required(field: "Shortcut Key")
        }
    }
}
