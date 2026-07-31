import SwiftUI
import UserNotifications

@main
struct AlarmApp: App {
    @StateObject private var alarmManager = AlarmManager()
    
    var body: some Scene {
        WindowGroup {
            AlarmView(alarmManager: alarmManager)
                .frame(width: 375, height: 812)
        }
        .windowStyle(.automatic)
    }
}
