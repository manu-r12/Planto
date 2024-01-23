//
//  PlantInfoBoxView.swift
//  Planto
//
//  Created by Manu on 2024-01-10.
//

import SwiftUI

struct PlantInfoBoxView: View {
    var body: some View {
        VStack( spacing: 10){
            Image("p1")
                .resizable()
                .scaledToFit()
                .frame(width: 110, height: 110)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack {
                Text("American Pihyx")
                    .font(.custom("Montserrat-Regular", size: 13))
                    .fontWeight(.semibold)
                .kerning(1.3)
            }
            HStack(spacing: 40){
                Text("Amount: 20")
                    .font(.custom("Montserrat-Regular", size: 12))
               
                
                Image(systemName: "arrow.right.circle.fill")
                
            }
        }
        .padding(15)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        
        
        
    }
}

#Preview {
    PlantInfoBoxView()
}
