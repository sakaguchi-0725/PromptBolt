//
//  DataManager.swift
//
//  PromptBolt
//  GitHub: https://github.com/sakaguchi-0725/PromptBolt
//
//  Created by Kazuma Sakaguchi on 2025/08/21.
//
//  Copyright © 2025 Kazuma Sakaguchi.
//  Licensed under the MIT License.
//

import SwiftData

final class DataManager {
    private init() {}
    
    private let schema = Schema([Prompt.self])
    
    lazy var production: ModelContainer = {
        createContainer(inMemory: false)
    }()
    
    lazy var testing: ModelContainer = {
        createContainer(inMemory: true)
    }()
    
    private func createContainer(inMemory: Bool) -> ModelContainer {
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly:
                                            inMemory)
        
        do {
            return try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    static let shared = DataManager()
}

extension DataManager {
    @MainActor
    static func previewContainer() -> ModelContainer {
        let container = DataManager.shared.testing
        let context = container.mainContext
        
        // サンプルデータを作成
        let sampleShortcut1 = ShortcutKey(
            modifierKeys: [ModifierKey.command.rawValue], 
            mainKey: CharacterKey.c.rawValue
        )
        let sampleShortcut2 = ShortcutKey(
            modifierKeys: [ModifierKey.command.rawValue, ModifierKey.shift.rawValue], 
            mainKey: CharacterKey.v.rawValue
        )
        let sampleShortcut3 = ShortcutKey(
            modifierKeys: [ModifierKey.command.rawValue, ModifierKey.option.rawValue], 
            mainKey: CharacterKey.p.rawValue
        )
        
        let prompt1 = Prompt(
            title: "Hello World", 
            content: "Hello, World!", 
            shortcutKey: sampleShortcut1
        )
        let prompt2 = Prompt(
            title: "Sample Text", 
            content: "This is a sample text for testing.", 
            shortcutKey: sampleShortcut2
        )
        let prompt3 = Prompt(
            title: "Long Sample", 
            content: "This is a very long sample text that demonstrates how the preview looks with longer content.", 
            shortcutKey: sampleShortcut3
        )
        
        context.insert(prompt1)
        context.insert(prompt2)
        context.insert(prompt3)
        
        return container
    }
}
