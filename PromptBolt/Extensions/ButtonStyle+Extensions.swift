//
//  ButtonStyle+Extensions.swift
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

extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: PrimaryButtonStyle { .init() }
}

extension ButtonStyle where Self == SecondaryButtonStyle {
    static var secondary: SecondaryButtonStyle { .init() }
}

struct PrimaryButtonStyle: ButtonStyle {
    @State private var isHovered = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(isHovered ? .accent.opacity(0.8) : .accent)
            .foregroundStyle(.white)
            .bold()
            .cornerRadius(4)
            .onHover { hovering in
                isHovered = hovering
            }
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    @State private var isHovered = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(isHovered ? .gray.opacity(0.2) : .clear)
            .cornerRadius(4)
            .onHover { hovering in
                isHovered = hovering
            }
    }
}
