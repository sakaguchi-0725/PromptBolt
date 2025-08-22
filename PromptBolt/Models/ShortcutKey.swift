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

struct ShortcutKey: Codable {
    let modifierKeys: [ModifierKey]
    let mainKey: CharacterKey
    
    var displayString: String {
        let modifierString = modifierKeys.map { $0.label }.joined()
        return "\(modifierString)\(mainKey.label)"
    }
}
