//
//  PromptState.swift
//
//  PromptBolt
//  GitHub: https://github.com/sakaguchi-0725/PromptBolt
//
//  Created by Kazuma Sakaguchi on 2025/08/23.
//
//  Copyright © 2025 Kazuma Sakaguchi.
//  Licensed under the MIT License.
//

import Foundation
import SwiftData

@Observable
@MainActor
final class PromptState {
    private(set) var prompts: [Prompt] = []
    
    private let context: ModelContext
    private let shortcutManager: ShortcutManager
    
    init(context: ModelContext, shortcutManager: ShortcutManager = .shared) {
        self.context = context
        self.shortcutManager = shortcutManager
        self.prompts = self.fetchPrompts()
    }
    
    private func fetchPrompts() -> [Prompt] {
        let descriptor = FetchDescriptor<Prompt>(
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        return (try? self.context.fetch(descriptor)) ?? []
    }
    
    func addPrompt(_ prompt: Prompt) throws {
        guard !self.shortcutManager.isAlreadyRegistered(prompt.shortcutKey) else {
            throw ShortcutError.alreadyRegistered
        }
        
        do {
            self.context.insert(prompt)
            try self.context.save()
            
            try self.shortcutManager.register(
                ShortcutProvider(
                    id: prompt.id,
                    shortcutKey: prompt.shortcutKey,
                    content: prompt.content
                )
            )
            
            prompts.insert(prompt, at: 0)
        } catch {
            self.context.rollback()
            throw error
        }
    }
    
    func updatePrompt(_ prompt: Prompt) throws {
        do {
            try self.context.save()
            try self.shortcutManager.update(
                ShortcutProvider(
                    id: prompt.id,
                    shortcutKey: prompt.shortcutKey,
                    content: prompt.content
                )
            )
            
            if let index = prompts.firstIndex(where: { $0.id == prompt.id }) {
                prompts[index] = prompt
            }
        } catch {
            self.context.rollback()
            throw error
        }
    }
    
    func removePrompt(_ prompt: Prompt) throws {
        do {
            self.context.delete(prompt)
            try self.context.save()
            
            try self.shortcutManager.unregister(prompt.id)
            
            prompts.removeAll { $0.id == prompt.id }
        } catch {
            self.context.rollback()
            throw error
        }
    }
}
