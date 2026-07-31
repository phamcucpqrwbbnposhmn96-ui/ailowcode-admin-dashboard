import Foundation
import UserNotifications
import SwiftUI

class AlarmManager: ObservableObject {
    @Published var alarms: [Alarm] = []
    
    init() {
        requestNotificationAuthorization()
        setupCategories()
        loadAlarmsFromUserDefaults()
    }
    
    func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notification authorization error: \(error)")
            } else if granted {
                print("Notification permission granted")
            }
        }
    }
    
    func addAlarm(alarm: Alarm) {
        alarms.append(alarm)
        scheduleNotification(for: alarm)
        saveAlarmsToUserDefaults()
    }
    
    func deleteAlarm(at indexSet: IndexSet) {
        alarms.remove(atOffsets: indexSet)
        saveAlarmsToUserDefaults()
    }
    
    private func scheduleNotification(for alarm: Alarm) {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "⏰ 闹钟"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        content.body = "时间到了！\(formatter.string(from: alarm.time))"
        content.sound = .default
        content.categoryIdentifier = "ALARM_CATEGORY"
        content.userInfo = ["alarmId": alarm.id.uuidString]
        
        var dateComponents = DateComponents()
        let now = Date()
        var alarmDate = alarm.time
        
        if alarmDate < now {
            alarmDate = alarmDate.adding(.day, value: 1)
        }
        
        dateComponents.hour = alarmDate.hour
        dateComponents.minute = alarmDate.minute
        dateComponents.second = alarmDate.second
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: alarm.isDaily)
        
        let request = UNNotificationRequest(
            identifier: alarm.id.uuidString,
            content: content,
            trigger: trigger
        )
        
        center.add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error)")
            } else {
                print("Scheduled for \(alarm.time)")
            }
        }
    }
    
    private func loadAlarmsFromUserDefaults() { self.alarms = [] }
    private func saveAlarmsToUserDefaults() {}
    
    private func setupCategories() {
        let snoozeAction = UNNotificationAction(
            identifier: "SNOOZE_ACTION", title: "贪睡", options: [.foreground])
        let dismissAction = UNNotificationAction(
            identifier: "DISMISS_ACTION", title: "关闭", options: [.destructive])
        let category = UNNotificationCategory(
            identifier: "ALARM_CATEGORY", actions: [snoozeAction, dismissAction],
            intentIdentifiers: [], intentOptions: .hidden)
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
}
