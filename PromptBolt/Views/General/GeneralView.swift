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
    @Environment(SettingsState.self) private var settingsState
    
    var body: some View {
        @Bindable var bindableSettings = settingsState
        
        VStack (spacing: 20) {
            HStack {
                Text("Current version")
                Spacer()
                Text(settingsState.currentVersion)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(Color(.windowBackgroundColor))
            .overlay(
                Divider(),
                alignment: .bottom
            )
            .padding(.horizontal, -20)
            .padding(.top, -20)
            
            VStack(spacing: 10) {
                GeneralCard(title: "Launch on start", isOn: $bindableSettings.launchOnStart)
                
                GeneralCard(title: "Auto update check", isOn: $bindableSettings.autoUpdateCheck)
            }
        }
    }
}

// MARK: - GeneralCard
struct GeneralCard: View {
    let title: String
    @Binding var isOn: Bool
    
    var body: some View {
        Card {
            HStack {
                Text(title)
                Spacer()
                Toggle("", isOn: $isOn)
                    .toggleStyle(SwitchToggleStyle())
            }
        }
    }
}

#Preview {
    let updateService = UpdateService(autoUpdateEnabled: false, notificationService: NotificationService())
    
    VStack {
        GeneralView()
            .environment(SettingsState(updateService: updateService))
    }.padding()
}
