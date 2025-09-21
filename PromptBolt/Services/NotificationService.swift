//
//  NotificationService.swift
//
//  PromptBolt
//  GitHub: https://github.com/sakaguchi-0725/PromptBolt
//
//  Created by Kazuma Sakaguchi on 2025/09/18.
//
//  Copyright © 2025 Kazuma Sakaguchi.
//  Licensed under the MIT License.
//

import Foundation
import UserNotifications

final class NotificationService: NSObject, UNUserNotificationCenterDelegate {
    private let center = UNUserNotificationCenter.current()
    private var notificationHandlers: [String: () -> Void] = [:]

    override init() {
        super.init()
        center.delegate = self
        
        Task {
            await requestPermission()
        }
    }

    @MainActor
    func requestPermission() async -> Bool {
        do {
            let granted = try await center.requestAuthorization(options: [.alert, .badge, .sound])
            return granted
        } catch {
            return false
        }
    }

    func sendNotification(identifier: String, title: String, body: String) async {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body

        let request = UNNotificationRequest(
            identifier: identifier,
            content: content,
            trigger: nil
        )

        do {
            try await center.add(request)
        } catch {
            print("Failed to send notification: \(error)")
        }
    }

    func removeNotification(identifier: String) {
        center.removeDeliveredNotifications(withIdentifiers: [identifier])
    }

    func removeAllNotifications() {
        center.removeAllDeliveredNotifications()
    }
    
    func registerNotificationHandler(identifier: String, handler: @escaping () -> Void) {
        notificationHandlers[identifier] = handler
    }
    
    func unregisterNotificationHandler(identifier: String) {
        notificationHandlers.removeValue(forKey: identifier)
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let identifier = response.notification.request.identifier
        
        if response.actionIdentifier == UNNotificationDefaultActionIdentifier,
            let handler = notificationHandlers[identifier] {
            handler()
        }
        
        completionHandler()
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound])
    }
}
