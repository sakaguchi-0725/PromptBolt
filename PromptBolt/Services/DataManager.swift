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
