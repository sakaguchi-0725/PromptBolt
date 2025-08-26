//
//  ShortcutKey.swift
//
//  PromptBolt
//  GitHub: https://github.com/sakaguchi-0725/PromptBolt
//
//  Created by Kazuma Sakaguchi on 2025/08/21.
//
//  Copyright © 2025 Kazuma Sakaguchi.
//  Licensed under the MIT License.
//

struct ShortcutKey: Codable, Equatable {
    let modifierKeys: [UInt32]
    let mainKey: UInt32
}

extension ShortcutKey {
    var modifiers: [ModifierKey] {
        modifierKeys.compactMap { ModifierKey(rawValue: $0) }
    }
    
    var characterKey: CharacterKey? {
        CharacterKey(rawValue: mainKey)
    }
    
    var displayString: String {
        let modifierString = modifiers.map { $0.label }.joined()
        let keyString = characterKey?.label ?? ""
        return "\(modifierString)\(keyString)"
    }
}
