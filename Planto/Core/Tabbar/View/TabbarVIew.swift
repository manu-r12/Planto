//
//  TabbarVIew.swift
//  Planto
//
//  Created by Manu on 2024-01-10.
//

import SwiftUI

struct TabbarVIew: View {
    
    @State var selectedItem = 0
    var body: some View {
        
        TabView(selection: $selectedItem){
            HomeScreenView()
                .tabItem {
                    VStack{
                        Image(systemName: "bell")
                        Text("Reminders").foregroundStyle(.black)
                    }
                }
            
            Text("Settings")
                .tabItem {
                    VStack{
                        Image(systemName: "book.closed")
                        Text("Botony").foregroundStyle(.black)
                    }
                }
                
        }
        .ignoresSafeArea(.all)

        .tint(.black)
 
    }
}

#Preview {
    TabbarVIew()
}
