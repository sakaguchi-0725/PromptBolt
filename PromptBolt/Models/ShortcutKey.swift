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
    let modifierKeys: [UInt32]
    let mainKey: UInt32
}
