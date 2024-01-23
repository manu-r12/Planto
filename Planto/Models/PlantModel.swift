//
//  PlantModel.swift
//  Planto
//
//  Created by Manu on 2024-01-11.
//

import Foundation


struct Plant: Identifiable , Hashable, Codable{
    let id: Int
    var name: String
    var image: String
    
}


class DeveloperClass {
    
    static let shared = DeveloperClass()
    
    var plantReminder: [Reminder] = [
       
    
    ]
     
    var plants : [Plant] = [
        .init(id: 1, name: "Animalia", image: "p1"),
        .init(id: 2, name: "Cacacee", image: "cact"),
        .init(id: 3, name: "Angiospermae", image: "p2"),
        .init(id: 4, name: "Monstera Delicosa", image: "p4"),
        .init(id: 5, name: "Capsicum", image: "p1"),
        .init(id: 6, name: "StrawBerry ", image: "strawberry"),
        .init(id: 7, name: "Annual Vinca", image: "anv"),
        .init(id: 8, name: "Balloon Flower", image: "bf"),
        
    ]
    
    func getPlants() -> [Plant]{
        return plants
    }
   
    
}
