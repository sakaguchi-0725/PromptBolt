//
//  UpdateService.swift
//
//  PromptBolt
//  GitHub: https://github.com/sakaguchi-0725/PromptBolt
//
//  Created by Kazuma Sakaguchi on 2025/08/28.
//
//  Copyright © 2025 Kazuma Sakaguchi.
//  Licensed under the MIT License.
//

import AppKit
import Sparkle

let UPDATE_NOTIFICATION_IDENTIFIER = "UpdateCheck"

final class UpdateService: NSObject, SPUUpdaterDelegate, SPUStandardUserDriverDelegate {
    private var updaterController: SPUStandardUpdaterController!
    private let notificationService: NotificationService
    
    var setUpdateAvailable: ((Bool) -> Void)?

    var autoUpdateEnabled: Bool {
        didSet {
            updaterController.updater.automaticallyChecksForUpdates = autoUpdateEnabled
        }
    }

    init (autoUpdateEnabled: Bool, notificationService: NotificationService) {
        self.notificationService = notificationService
        self.autoUpdateEnabled = autoUpdateEnabled
        
        super.init()
        
        self.updaterController = SPUStandardUpdaterController(
            startingUpdater: true,
            updaterDelegate: self,
            userDriverDelegate: self
        )
        
        notificationService.registerNotificationHandler(
            identifier: UPDATE_NOTIFICATION_IDENTIFIER
        ) { [weak self] in
            self?.checkForUpdates()
        }
        
        updaterController.updater.automaticallyChecksForUpdates = autoUpdateEnabled
    }
    
    func checkForUpdates() {
        updaterController.updater.checkForUpdates()
    }
    
    // Called when a new update is found
    func updater(_ updater: SPUUpdater, didFindValidUpdate item: SUAppcastItem) {
        setUpdateAvailable?(true)
    }
    
    // Called when no update is found
    func updaterDidNotFindUpdate(_ updater: SPUUpdater, error: Error) {
        setUpdateAvailable?(false)
    }
    
    // Called when user makes a choice about update
    func updater(_ updater: SPUUpdater, userDidMake choice: SPUUserUpdateChoice, forUpdate updateItem: SUAppcastItem, state: SPUUserUpdateState) {
        switch choice {
        case .skip:
            setUpdateAvailable?(true)
        case .dismiss:
            setUpdateAvailable?(false)
        case .install:
            setUpdateAvailable?(false)
        @unknown default:
            break
        }
    }
    
    func standardUserDriverWillHandleShowingUpdate(_ handleShowingUpdate: Bool, forUpdate update: SUAppcastItem, state: SPUUserUpdateState) {
        NSApp.setActivationPolicy(.regular)
        
        if !state.userInitiated {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                NSApp.dockTile.badgeLabel = "1"
                NSApp.dockTile.display()
            }
            
            Task {
                await notificationService.sendNotification(
                    identifier: UPDATE_NOTIFICATION_IDENTIFIER,
                    title: "A new update is available",
                    body: "Version \(update.displayVersionString) is now available"
                )
            }
        }
    }
    
    func standardUserDriverDidReceiveUserAttention(forUpdate update: SUAppcastItem) {
        NSApp.dockTile.badgeLabel = ""
        notificationService.removeNotification(identifier: UPDATE_NOTIFICATION_IDENTIFIER)
    }
    
    func standardUserDriverWillFinishUpdateSession() {
        NSApp.setActivationPolicy(.accessory)
    }
    
    var supportsGentleScheduledUpdateReminders: Bool {
        return true
    }
    
    func standardUserDriverShouldHandleShowingScheduledUpdate(_ update: SUAppcastItem, andInImmediateFocus immediateFocus: Bool) -> Bool {
        return false
    }
}
