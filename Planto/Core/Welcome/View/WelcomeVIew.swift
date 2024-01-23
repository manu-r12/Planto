//
//  WelcomeVIew.swift
//  Planto
//
//  Created by Manu on 2024-01-10.
//

import SwiftUI

struct WelcomeVIew: View {
    @StateObject var viewModel = WelcomeVIewModel.shared
    var body: some View {
        ZStack{
            Image("bgPlant")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                
                VStack(alignment: .leading){
                    Text("Enjoy you life")
                    HStack{
                        Text("With the")
                            .foregroundStyle(.black)
                        Text("Nature")
                            .foregroundStyle(Color(.systemGreen))
                    }
                    .padding(10)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    Text("in your house")
        
                }
                .padding(.top, 121)
                .foregroundColor(.white)
                .font(.custom("Montserrat-bold", size: 34))
                .fontWeight(.bold)
             
                Spacer()
                
                VStack {
                    Button(action: {
                        AddPlantController.shared.askPermission()
                        viewModel.closeTheView()
                        print(viewModel.isClosed)
                    }, label: {
                        Text("Get Started")
                            .font(.custom("Montserrat-Medium", size: 19))
                            .foregroundStyle(.black)
                            .fontWidth(.standard)
                            .frame(width: 300, height: 50)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .kerning(1)
                    })
                }
              
           
            }
        }
    }
}

#Preview {
    WelcomeVIew()
}
