//
//  AppDelegate.swift
//  BGTaskHandlerTest
//
//  Created by Atul on 08/08/24.
//

import UIKit
import SwiftUI
import BackgroundTasks
import Foundation


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let taskId = "com.devname.appname.refresh.refresh"
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.        
        BGTaskScheduler.shared.register(forTaskWithIdentifier: taskId, using: DispatchQueue.main) { task in
            self.handleAppRefresh(task: task as! BGProcessingTask)
        }
        AppSettings.shared.proceedToLogin()
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("App Entered Background")
        scheduleAppRefresh()
    }
    
    func scheduleAppRefresh() {
        let request = BGProcessingTaskRequest(identifier: taskId)
        request.requiresNetworkConnectivity = true
        request.earliestBeginDate = Date(timeIntervalSinceNow: 20 * 60) // 20 minutes from now (Note: System decides actual execution time)
        do {
            try BGTaskScheduler.shared.submit(request)
            print("BGTask Scheduled")
            print("Satrt Scheduler ---\(Date())")
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }
    
    func handleAppRefresh(task: BGProcessingTask) {
        //Scehdules a second refresh
        scheduleAppRefresh()
        // BGNotification()
        print("BG Background Task fired")
        // Perform your background task
        let queue = OperationQueue()
        queue.addOperation {
            // Perform your background work here
            self.performBackgroundTask {
                task.setTaskCompleted(success: true)
            }
        }
        // Ensure the task completes within the system's allowed time
        task.expirationHandler = {
            queue.cancelAllOperations()
        }
    }
    
    func performBackgroundTask(completion: @escaping () -> Void) {
        // Simulate a background task by waiting for a few seconds
        DispatchQueue.global().asyncAfter(deadline: .now()) {
            // Perform your actual background task here
            print("Perform your actual background task here")
            print("Stop Scheduler ---\(Date())")
            completion()
        }
    }
}

extension AppDelegate{
    class func getAppDelegate() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
    func getWindowNavigation()-> UINavigationController?{
        guard let window = self.window else {
            return nil
        }
        guard let nav = window.rootViewController as? UINavigationController else {
            return nil
        }
        return nav
    }
}
