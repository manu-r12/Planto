
import Foundation
import UserNotifications

struct ReminderScheduleManager {
    
    static func scheduleNotification(for reminder: Reminder){
        
        var trigger: UNNotificationTrigger?
        
        let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: reminder.time!)
        trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        
        let content = UNMutableNotificationContent()
        content.title = "Where are you?"
        content.body = reminder.message!
        content.sound = UNNotificationSound.defaultCritical
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        print("Set SuccessFully")
        
    }
    
}
