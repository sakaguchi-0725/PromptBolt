//
//  Item.swift
//  PromptBolt
//
//  Created by Kazuma Sakaguchi on 2025/08/20.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
