//
//  ModifierKey.swift
//
//  PromptBolt
//  GitHub: https://github.com/sakaguchi-0725/PromptBolt
//
//  Created by Kazuma Sakaguchi on 2025/08/22.
//
//  Copyright © 2025 Kazuma Sakaguchi.
//  Licensed under the MIT License.
//

enum ModifierKey: UInt32, CaseIterable, Codable {
    case control = 0x3B
    case option = 0x3A
    case shift = 0x38
    case command = 0x37
    
    var label: String {
        switch self {
        case .control:
            return "⌃"
        case .option:
            return "⌥"
        case .shift:
            return "⇧"
        case .command:
            return "⌘"
        }
    }
}
