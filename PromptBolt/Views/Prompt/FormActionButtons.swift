//
//  FormActionButtons.swift
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

struct FormActionButtons: View {
    let onCancel: () -> Void
    let onSubmit: () -> Void
    let submitTitle: String
    
    var body: some View {
        HStack {
            Button {
                onCancel()
            } label: {
                Text("Cancel")
                    .padding(.vertical, 8)
                    .padding(.horizontal, 10)
            }
            .buttonStyle(.secondary)
            
            Spacer()
            
            Button {
                onSubmit()
            } label: {
                Text(submitTitle)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 10)
            }
            .buttonStyle(.primary)
        }
    }
}

