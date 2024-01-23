//
//  ContentView.swift
//  Planto
//
//  Created by Manu on 2024-01-10.
//

import SwiftUI


struct ContentView: View {
    @StateObject var viewModel = ContentVIewModel()
    @State var homeViewModel = HomeViewModel.shared
    @Environment(\.managedObjectContext) var managedObjContext
        
    
    var body: some View {
        Group{
            if(!viewModel.isClosed){
                WelcomeVIew()
            }else{
                TabbarVIew()
                    .onAppear{
                        ReminderContainer.shared.loadReminders(context: managedObjContext)
                    }
            }
        }
    }


}

#Preview {
    ContentView()
}
