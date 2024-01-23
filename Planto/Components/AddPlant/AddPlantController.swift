import Foundation
import CoreData
import UIKit
import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
   

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker     

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                AddPlantController.shared.setImage(image: uiImage)
            }
            picker.dismiss(animated: true, completion: nil)
        }

       
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}


class AddPlantController : ObservableObject {
    @Published var selectedImage: UIImage?
    
    @MainActor
    @Published var pickedItem:PhotosPickerItem? {
        didSet { Task {
            if let pickedItem,
               let data = try? await pickedItem.loadTransferable(type: Data.self){
                if let image = UIImage(data: data){
                    selectedImage = image
                }
            }
            pickedItem = nil
        }}
    }
    
    static let shared = AddPlantController()
    
    func setImage(image: UIImage){
        selectedImage = image
    }
    
    func askPermission(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success{
                print("Access Granted")
            }else if let error = error{
                print(error.localizedDescription)
            }
        }
    }
    
    func addReminders(withName name: String,withAmount amount: String, withTime time: Date, withMark mark: String, withContext context: NSManagedObjectContext){
        let newReminder = Reminder(context: context)
        newReminder.id = UUID()
        newReminder.amount = amount
        newReminder.name = name
        newReminder.image = selectedImage
        newReminder.message = "Hey it's time to water your \(name) plant"
        newReminder.time = time
        newReminder.mark = mark
        ReminderContainer.shared.saveReminders(context: context)
        ReminderScheduleManager.scheduleNotification(for: newReminder)
      
    }
    
}
