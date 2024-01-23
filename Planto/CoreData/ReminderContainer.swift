import Foundation
import CoreData
import SwiftUI


class ReminderContainer: ObservableObject{
    @Published  var reminders = [Reminder]()

    let container = NSPersistentContainer(name: "ReminderCoreData")
    
    static let shared  = ReminderContainer()
    
    init(){
        ImageTransformer.register()
        container.loadPersistentStores { _, error in
            if let error = error{
                print("Error in core Data:", error.localizedDescription)
            }
        }
        
    }
    
    
    
    func saveReminders(context: NSManagedObjectContext){
        do{
            try context.save()
            print("Saved Successfully")
        }catch{
            print("Error found during saving...", error.localizedDescription)
        }
    }
    
    
    
    func loadReminders(context: NSManagedObjectContext){
        let request : NSFetchRequest<Reminder> = Reminder.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "time", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        do{
            let loadedData = try context.fetch(request)
            reminders = loadedData
            print("Loaded data:", reminders)
            reminders.forEach { reminder in
                print("the reminder name:", reminder.message!)
            }
            
        }catch{
            print(error.localizedDescription)
        }
    
    }
    
    //function to update a reminder
    func updateReminder(theReminder reminder : Reminder,withName name: String,withAmount amount: String, withTime time: Date, withMark mark: String, withImage image: UIImage,withContextcontext context : NSManagedObjectContext){
        
        let fetchRequest: NSFetchRequest<Reminder> = Reminder.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", reminder.id! as CVarArg)
        
       
        do {
            let fetchedReminder = try context.fetch(fetchRequest)
            
            if let reminder_that_needs_to_be_updated = fetchedReminder.first{
                reminder_that_needs_to_be_updated.name = name
                reminder_that_needs_to_be_updated.message = "Hey it's time to water your \(name) plant"
                reminder_that_needs_to_be_updated.time = time
                reminder_that_needs_to_be_updated.amount = amount
                reminder_that_needs_to_be_updated.image = image
                reminder_that_needs_to_be_updated.mark =  mark
                
                saveReminders(context: context)
                ReminderScheduleManager.scheduleNotification(for: reminder_that_needs_to_be_updated)
            }
        }catch{
            print("Error in updating the reminde ->", error.localizedDescription)
        }
                
        loadReminders(context: context)
    }
    
    
    // function to delete ancy reminder: Reminder
    func deleteReminder(theReminder reminder: Reminder){
        guard let context = reminder.managedObjectContext else {return}
        context.delete(reminder)
        do {
            try context.save()
        }catch{
            print("error in saving after delettion")
        }
        
    }
    
   
    
    
    
   
}
