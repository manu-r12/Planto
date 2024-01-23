//
//  PlantInfoBoxView-List.swift
//  Planto
//
//  Created by Manu on 2024-01-10.
//

import SwiftUI
import CoreData
struct PlantInfoBoxView_List: View {
    let reminder: FetchedResults<Reminder>.Element
    var body: some View {
        HStack(alignment: .center, spacing: 18){
            Image(uiImage: reminder.image!)
                .resizable()
                .frame(width: 45, height: 45)
                .scaledToFill()
                .clipShape(Circle())
            
            
            VStack(alignment: .leading, spacing: 8){
                Text(reminder.name ?? "Some Plant")
                    .font(.custom("Montserrat-Medium", size: 13))
                    .kerning(1.1)
                Text("Qunatity - \(reminder.amount!)")
                    .font(.custom("Montserrat-Regular", size: 10))
                    .kerning(1.3)
                    .foregroundStyle(Color(.black))
                
            }
            Spacer()
            
            Image(systemName: "chevron.right")
                .padding(.trailing, 10)
            
        }
        .padding(12)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 50))
        .padding(.horizontal)
       
    }
}


struct PlantInfoBoxView_List_PreviewProvider: PreviewProvider {
    
    static var previews: some View {
        let viewContext = ReminderContainer.shared.container.viewContext
        let previewItem = Reminder(context: viewContext)
        previewItem.name = "Heron Ballon"
        previewItem.message = "It is time"
        previewItem.image = UIImage(named: "p1")
        previewItem.mark = "At my desk"
        previewItem.time = Date.now
        previewItem.amount =  "1"
        return PlantInfoBoxView_List(reminder: previewItem)
    }
}

