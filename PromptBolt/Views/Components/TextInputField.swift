//
//  TextInputField.swift
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

struct TextInputField: View {
    let label: String?
    let placeholder: String?
    @Binding var input: String
    
    init(label: String? = nil, placeholder: String? = nil, input: Binding<String>) {
        self.label = label
        self.placeholder = placeholder
        self._input = input
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let label = label {
                Text(label)
                    .font(.headline)
                    .foregroundColor(Color(.labelColor))
            }
            
            TextField(
                placeholder ?? "",
                text: $input
            )
            .textFieldStyle(PlainTextFieldStyle())
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .background(Color(NSColor.windowBackgroundColor))
            .cornerRadius(4)
            .overlay(RoundedRectangle(cornerRadius: 4)
                .stroke(
                    .separator,
                    lineWidth: 1
                )
            )
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        TextInputField(label: "Name", placeholder: "Enter your name", input: .constant(""))
        TextInputField(placeholder: "No label", input: .constant(""))
        TextInputField(label: "Only label", input: .constant(""))
    }
    .padding()
}
