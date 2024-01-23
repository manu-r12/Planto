
import Foundation
import Combine
import CoreData
class HomeViewModel: ObservableObject, Observable {
    @Published var reminders = [Reminder]()
    private var cancellable = Set<AnyCancellable>()
    @Published var IsLoading = false
    
    static let shared = HomeViewModel()

    init(){
        setUpSubscirber()
    }
    
     private func setUpSubscirber() {
         ReminderContainer.shared.$reminders.sink { reminder in
             self.reminders = reminder
         }.store(in: &cancellable)
         
         
    }
    
    func refresh(context: NSManagedObjectContext) {
        ReminderContainer.shared.loadReminders(context: context)
        reminders = []
    }
    
    func loadtheData(withContext context: NSManagedObjectContext){
        IsLoading = true
        ReminderContainer.shared.loadReminders(context: context)
        reminders = ReminderContainer.shared.reminders
        IsLoading = false
    }
    
}
