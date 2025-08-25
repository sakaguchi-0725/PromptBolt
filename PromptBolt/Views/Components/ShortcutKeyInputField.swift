//
//  ShortcutKeyInputField.swift
//
//  PromptBolt
//  GitHub: https://github.com/sakaguchi-0725/PromptBolt
//
//  Created by Kazuma Sakaguchi on 2025/08/25.
//
//  Copyright © 2025 Kazuma Sakaguchi.
//  Licensed under the MIT License.
//

import SwiftUI

// MARK: - ShortcutKeyInputField
struct ShortcutKeyInputField: View {
    @Binding var shortcutKey: ShortcutKey?
    @State private var isRecording = false
    
    var body: some View {
        Button {
            isRecording.toggle()
        } label: {
            HStack {
                Text(displayText)
                    .foregroundColor(textColor)
                Spacer()
                Image(systemName: isRecording ? "stop.circle" : "keyboard")
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .background(backgroundColor)
            .cornerRadius(4)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(borderColor, lineWidth: isRecording ? 2 : 1)
            )
        }
        .buttonStyle(.plain)
        .overlay(
            KeyEventCatcher(
                isRecording: $isRecording,
                shortcutKey: $shortcutKey
            )
            .opacity(isRecording ? 1 : 0)
        )
    }
    
    private var displayText: String {
        if isRecording {
            return "Press keys for shortcut..."
        } else if let shortcutKey = shortcutKey {
            return shortcutKey.displayString
        } else {
            return "Click to set shortcut key"
        }
    }
    
    private var textColor: Color {
        if isRecording {
            return .primary
        } else if shortcutKey != nil {
            return .primary
        } else {
            return Color(NSColor.placeholderTextColor)
        }
    }
    
    private var backgroundColor: Color {
        isRecording ? .accent.opacity(0.1) : Color(NSColor.windowBackgroundColor)
    }
    
    private var borderColor: Color {
        isRecording ? .accent : Color(NSColor.separatorColor)
    }
}

// MARK: - KeyEventCatcher
struct KeyEventCatcher: NSViewRepresentable {
    @Binding var isRecording: Bool
    @Binding var shortcutKey: ShortcutKey?
    
    func makeNSView(context: Context) -> NSView {
        let view = KeyCatcherView()
        view.onKeyPressed = { modifiers, keyCode in
            if !modifiers.isEmpty || keyCode != 0 {
                let shortcut = ShortcutKey(
                    modifierKeys: modifiers,
                    mainKey: keyCode
                )
                shortcutKey = shortcut
                isRecording = false
            }
        }
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
        if let keyView = nsView as? KeyCatcherView {
            keyView.isActive = isRecording
        }
    }
}

class KeyCatcherView: NSView {
    var onKeyPressed: (([UInt32], UInt32) -> Void)?
    var isActive = false {
        didSet {
            if isActive {
                window?.makeFirstResponder(self)
            }
        }
    }
    
    override var acceptsFirstResponder: Bool { isActive }
    override var canBecomeKeyView: Bool { isActive }
    
    override func keyDown(with event: NSEvent) {
        guard isActive else {
            super.keyDown(with: event)
            return
        }
        
        let modifiers = extractModifierKeys(from: event.modifierFlags)
        let keyCode = UInt32(event.keyCode)
        
        onKeyPressed?(modifiers, keyCode)
    }
    
    private func extractModifierKeys(from flags: NSEvent.ModifierFlags) -> [UInt32] {
        var modifiers: [UInt32] = []
        
        if flags.contains(.command) {
            modifiers.append(ModifierKey.command.rawValue)
        }
        if flags.contains(.option) {
            modifiers.append(ModifierKey.option.rawValue)
        }
        if flags.contains(.control) {
            modifiers.append(ModifierKey.control.rawValue)
        }
        if flags.contains(.shift) {
            modifiers.append(ModifierKey.shift.rawValue)
        }
        
        return modifiers
    }
}

#Preview {
    VStack(spacing: 16) {
        ShortcutKeyInputField(shortcutKey: .constant(nil))
        ShortcutKeyInputField(shortcutKey: .constant(ShortcutKey(modifierKeys: [ModifierKey.command.rawValue], mainKey: CharacterKey.a.rawValue)))
    }
    .padding()
}
