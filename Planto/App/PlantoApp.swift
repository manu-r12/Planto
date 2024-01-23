//
//  PlantoApp.swift
//  Planto
//
//  Created by Manu on 2024-01-10.
//

import SwiftUI

@main
struct PlantoApp: App {
    @StateObject var dataContainer = ReminderContainer.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,dataContainer.container.viewContext)
        }
    }
}
