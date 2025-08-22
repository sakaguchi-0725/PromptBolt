//
//  ShortcutManager.swift
//
//  PromptBolt
//  GitHub: https://github.com/sakaguchi-0725/PromptBolt
//
//  Created by Kazuma Sakaguchi on 2025/08/22.
//
//  Copyright © 2025 Kazuma Sakaguchi.
//  Licensed under the MIT License.
//

import Foundation
import AppKit
import HotKey

enum ShortcutError: Error {
    case alreadyRegistered
    case invalidKey
    case notFound
}

struct ShortcutProvider {
    let id: UUID
    let shortcutKey: ShortcutKey
    let content: String
}

final class ShortcutManager {
    private var activeShortcutKeys: [UUID: HotKey] = [:]
    
    private init() {}
    
    /// Registers a new global keyboard shortcut for the given prompt.
    /// - Parameter shortcut: The shortcut configuration containing ID, key combination, and content
    /// - Throws: ShortcutError.alreadyRegistered if the key combination is already in use
    /// - Throws: ShortcutError.invalidKey if the key combination cannot be converted to a valid HotKey
    func register(_ shortcut: ShortcutProvider) throws {
        guard !isAlreadyRegistered(shortcut.shortcutKey) else {
            throw ShortcutError.alreadyRegistered
        }
        
        guard let hotKey = convertToHotKey(shortcut.shortcutKey) else {
            throw ShortcutError.invalidKey
        }
        
        hotKey.keyDownHandler = {
            DispatchQueue.main.async {
                self.pasteToClipboard(shortcut.content)
            }
        }
        
        activeShortcutKeys[shortcut.id] = hotKey
    }
    
    /// Unregisters a global keyboard shortcut by its unique identifier.
    /// - Parameter id: The unique identifier of the shortcut to remove
    /// - Throws: ShortcutError.notFound if no shortcut exists with the given ID
    func unregister(_ id: UUID) throws {
        guard activeShortcutKeys[id] != nil else {
            throw ShortcutError.notFound
        }
        
        activeShortcutKeys.removeValue(forKey: id)
    }
    
    /// Updates an existing shortcut by unregistering the old one and registering the new configuration.
    /// - Parameter shortcut: The new shortcut configuration to replace the existing one
    /// - Throws: ShortcutError.notFound if the shortcut ID doesn't exist
    /// - Throws: ShortcutError.alreadyRegistered if the new key combination conflicts with another shortcut
    /// - Throws: ShortcutError.invalidKey if the new key combination is invalid
    func update(_ shortcut: ShortcutProvider) throws {
        try unregister(shortcut.id)
        try register(shortcut)
    }
    
    /// Checks if a specific key combination is already registered as a global shortcut.
    /// - Parameter shortcutKey: The key combination to check for conflicts
    /// - Returns: true if the key combination is already in use, false otherwise
    func isAlreadyRegistered(_ shortcutKey: ShortcutKey) -> Bool {
        guard let targetHotKey = convertToHotKey(shortcutKey) else {
            return false
        }
        
        return activeShortcutKeys.values.contains { registeredHotKey in
            registeredHotKey.keyCombo.key == targetHotKey.keyCombo.key &&
            registeredHotKey.keyCombo.modifiers == targetHotKey.keyCombo.modifiers
        }
    }
    
    /// Converts a ShortcutKey to a HotKey instance that can be registered globally.
    /// - Parameter shortcutKey: The custom key combination structure
    /// - Returns: A HotKey instance if conversion is successful, nil if the key is invalid
    private func convertToHotKey(_ shortcutKey: ShortcutKey) -> HotKey? {
        guard let key = convertCharacterKeyToKey(shortcutKey.mainKey) else {
            return nil
        }
        
        let modifiers = convertModifierKeysToFlags(shortcutKey.modifierKeys)
        
        return HotKey(key: key, modifiers: modifiers)
    }
    
    /// Converts an array of custom ModifierKey enums to NSEvent.ModifierFlags.
    /// - Parameter modifierKeys: Array of modifier keys (command, option, control, shift)
    /// - Returns: Combined NSEvent.ModifierFlags for use with HotKey
    private func convertModifierKeysToFlags(_ modifierKeys: [ModifierKey]) -> NSEvent.ModifierFlags {
        var flags: NSEvent.ModifierFlags = []
        
        for modifier in modifierKeys {
            switch modifier {
            case .command:
                flags.insert(.command)
            case .option:
                flags.insert(.option)
            case .control:
                flags.insert(.control)
            case .shift:
                flags.insert(.shift)
            }
        }
        
        return flags
    }
    
    /// Converts a custom CharacterKey enum to a HotKey.Key enum.
    /// - Parameter characterKey: The character key to convert (a-z, 0-9)
    /// - Returns: Corresponding HotKey.Key if mapping exists, nil otherwise
    private func convertCharacterKeyToKey(_ characterKey: CharacterKey) -> Key? {
        switch characterKey {
        case .a: return .a
        case .b: return .b
        case .c: return .c
        case .d: return .d
        case .e: return .e
        case .f: return .f
        case .g: return .g
        case .h: return .h
        case .i: return .i
        case .j: return .j
        case .k: return .k
        case .l: return .l
        case .m: return .m
        case .n: return .n
        case .o: return .o
        case .p: return .p
        case .q: return .q
        case .r: return .r
        case .s: return .s
        case .t: return .t
        case .u: return .u
        case .v: return .v
        case .w: return .w
        case .x: return .x
        case .y: return .y
        case .z: return .z
        case .zero: return .zero
        case .one: return .one
        case .two: return .two
        case .three: return .three
        case .four: return .four
        case .five: return .five
        case .six: return .six
        case .seven: return .seven
        case .eight: return .eight
        case .nine: return .nine
        }
    }
    
    /// Pastes the given content by setting it to clipboard and simulating Command+V.
    /// This method is called when a registered shortcut is triggered.
    /// - Parameter content: The text content to paste into the active application
    private func pasteToClipboard(_ content: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(content, forType: .string)
        
        let source = CGEventSource(stateID: .hidSystemState)
        
        let keyDownEvent = CGEvent(keyboardEventSource: source, virtualKey: 0x09, keyDown: true)
        keyDownEvent?.flags = .maskCommand
        keyDownEvent?.post(tap: .cghidEventTap)
        
        let keyUpEvent = CGEvent(keyboardEventSource: source, virtualKey: 0x09, keyDown: false)
        keyUpEvent?.flags = .maskCommand
        keyUpEvent?.post(tap: .cghidEventTap)
    }
    
    static let shared = ShortcutManager()
}
