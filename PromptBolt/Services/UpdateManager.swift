//
//  UpdateManager.swift
//
//  PromptBolt
//  GitHub: https://github.com/sakaguchi-0725/PromptBolt
//
//  Created by Kazuma Sakaguchi on 2025/08/28.
//
//  Copyright © 2025 Kazuma Sakaguchi.
//  Licensed under the MIT License.
//

import Sparkle

final class UpdateManager: ObservableObject {
    private var updateTimer: Timer?
    private let updateCheckInterval: TimeInterval = 60 * 60 * 24
    private let updaterController: SPUStandardUpdaterController
    private let delegate: UpdateManagerDelegate
    
    @Published var hasUpdateAvailable = false
    @Published var latestVersion: String?
    
    var autoUpdateEnabled: Bool = SettingsManager.shared.autoUpdateCheck {
        didSet { configureAutoUpdate() }
    }
    
    private init () {
        self.delegate = UpdateManagerDelegate()
        updaterController = SPUStandardUpdaterController(
            startingUpdater: true,
            updaterDelegate: delegate,
            userDriverDelegate: nil
        )
        
        delegate.updateManager = self
        configureAutoUpdate()
    }
    
    func checkForUpdates() {
        updaterController.updater.checkForUpdates()
    }
    
    private func configureAutoUpdate() {
        updateTimer?.invalidate()
        
        guard autoUpdateEnabled else { return }
        
        updateTimer = Timer.scheduledTimer(withTimeInterval: updateCheckInterval, repeats: true) { [weak self] _ in
            self?.checkForUpdates()
        }
    }
    
    static let shared = UpdateManager()
    
    deinit {
        updateTimer?.invalidate()
    }
}

class UpdateManagerDelegate: NSObject, SPUUpdaterDelegate {
    weak var updateManager: UpdateManager?
    
    // Called when a new update is found
    func updater(_ updater: SPUUpdater, didFindValidUpdate item: SUAppcastItem) {
        print("New update available: \(item.versionString)")
        updateManager?.hasUpdateAvailable = true
        updateManager?.latestVersion = item.versionString
    }
    
    // Called when no update is found
    func updaterDidNotFindUpdate(_ updater: SPUUpdater, error: Error) {
        print("No updates found")
        updateManager?.hasUpdateAvailable = false
    }
    
    // Called when user makes a choice about update
    func updater(_ updater: SPUUpdater, userDidMake choice: SPUUserUpdateChoice, forUpdate updateItem: SUAppcastItem, state: SPUUserUpdateState) {
        switch choice {
        case .skip:
            print("User skipped update")
            updateManager?.hasUpdateAvailable = true
        case .dismiss:
            print("User dismissed update")
            updateManager?.hasUpdateAvailable = false
        case .install:
            print("User chose to install")
            updateManager?.hasUpdateAvailable = false
        @unknown default:
            break
        }
    }
}
