//
//  SecondaryButton.swift
//
//  PromptBolt
//  GitHub: https://github.com/sakaguchi-0725/PromptBolt
//
//  Created by Kazuma Sakaguchi on 2025/08/22.
//
//  Copyright © 2025 Kazuma Sakaguchi.
//  Licensed under the MIT License.
//

import SwiftUI

struct SecondaryButton: View {
    let label: String
    let action: () -> Void
    @State private var isHovered = false
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(label)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 6)
                .padding(.horizontal, 8)
                .background(isHovered ? Color.gray.opacity(0.2) : Color.clear)
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
        SecondaryButton(label: "test", action: {})
    }.padding()
}
