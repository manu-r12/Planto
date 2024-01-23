//
//  EditViewModel.swift
//  Planto
//
//  Created by Manu on 2024-01-17.
//

import Foundation
import SwiftyJSON
import Combine
import SwiftUI

class EditViewModel : ObservableObject{
    
    @Published var wikiData: JSON = []
    @Published var plantInfo: PlantInfo?
    private var cancellable = Set<AnyCancellable>()
    static let shared  = EditViewModel()
    
    init(){
        setUp()
    }
    
    private func setUp(){
        WikiApiManagar.shared.$flowerDataJson.sink { Data in
            self.wikiData = Data
            let pageId = self.wikiData["query"]["pageids"][0].stringValue
            let flowerDescription = self.wikiData["query"]["pages"][pageId]["extract"].stringValue
            let imageURL = self.wikiData["query"]["pages"][pageId]["thumbnail"]["source"].stringValue
            let plantData = PlantInfo(description: flowerDescription, imageURL: URL(string:imageURL))
            self.plantInfo = plantData
            print("================= the plant information ======================")
            print(flowerDescription)
        }.store(in: &cancellable)
    }
    
    
    func delete(reminder: Reminder){
        ReminderContainer.shared.deleteReminder(theReminder: reminder)
    }
   
  
    
}
