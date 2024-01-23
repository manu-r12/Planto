import Foundation
import CoreData
import UIKit
import SwiftUI
import PhotosUI

struct ImagePickerInUpdatePlantController: UIViewControllerRepresentable {
   
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePickerInUpdatePlantController

        init(parent: ImagePickerInUpdatePlantController) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                UpdatePlantController.shared.setImage(image: uiImage)
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


class UpdatePlantController : ObservableObject {
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
    
    static let shared = UpdatePlantController()
    
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
    
    func updateReminder(theReminder reminder: Reminder,withName name: String,withAmount amount: String, withTime time: Date, withMark mark: String, withContext context: NSManagedObjectContext){
      
        ReminderContainer.shared.updateReminder(theReminder: reminder, withName: name, withAmount: amount, withTime: time, withMark: mark, withImage: selectedImage!, withContextcontext: context)
      
    }
    
    
   
    
}
