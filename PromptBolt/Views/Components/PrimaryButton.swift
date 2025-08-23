//
//  PrimaryButton.swift
//
//  PromptBolt
//  GitHub: https://github.com/sakaguchi-0725/PromptBolt
//
//  Created by Kazuma Sakaguchi on 2025/08/23.
//
//  Copyright © 2025 Kazuma Sakaguchi.
//  Licensed under the MIT License.
//

import SwiftUI

struct PrimaryButton: View {
    let label: String
    let alignment: Alignment
    let action: () -> Void
    @State private var isHovered = false
    
    init(label: String, alignment: Alignment = .center, action: @escaping () -> Void) {
        self.label = label
        self.alignment = alignment
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(label)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
                .background(isHovered ? .accent.opacity(0.8) : .accent)
                .foregroundStyle(.white)
                .bold()
                .cornerRadius(4)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .onHover { hovering in
            isHovered = hovering
        }
    }
}

#Preview {
    VStack {
        PrimaryButton(label: "Button", action: {})
            .frame(width: 100, height: 30)
    }.padding()
}
