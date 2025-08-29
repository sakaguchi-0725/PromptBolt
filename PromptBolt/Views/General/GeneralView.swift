//
//  GeneralView.swift
//
//  PromptBolt
//  GitHub: https://github.com/sakaguchi-0725/PromptBolt
//
//  Created by Kazuma Sakaguchi on 2025/08/24.
//
//  Copyright © 2025 Kazuma Sakaguchi.
//  Licensed under the MIT License.
//

import SwiftUI

// MARK: - GeneralView
struct GeneralView: View {
    @StateObject private var settings: SettingsManager = .shared
    
    var body: some View {
        VStack(spacing: 10) {
            GeneralCard(title: "Launch on start", isOn: $settings.launchOnStart)
            
            GeneralCard(title: "Auto update check", isOn: $settings.autoUpdateCheck)
        }
    }
}

// MARK: - GeneralCard
struct GeneralCard: View {
    let title: String
    let isOn: Binding<Bool>
    
    var body: some View {
        Card {
            HStack {
                Text(title)
                Spacer()
                Toggle("", isOn: isOn)
                    .toggleStyle(SwitchToggleStyle())
            }
        }
    }
}

#Preview {
    VStack {
        GeneralView()
    }.padding()
}
