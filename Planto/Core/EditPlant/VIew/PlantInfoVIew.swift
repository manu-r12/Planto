//
//  PlantInfoVIew.swift
//  Planto
//
//  Created by Manu on 2024-01-18.
//

import SwiftUI
import URLImage

struct CustomCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct PlantInfoVIew: View {
    let plantInfo : PlantInfo
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            if !plantInfo.description.isEmpty {
                ScrollView(showsIndicators: false){
                    
                    VStack {
                        VStack{
                            if let imageURL = plantInfo.imageURL{
                                URLImage(imageURL) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                }
                            }else{
                                Image("p1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            }
                        }
                        .frame(width: 240 , height: 240)
                        .background(.black)
                        .clipShape(Circle())
                        .padding(8)
                        .background(.black)
                        .clipShape(Circle())
                        
                    .padding(.vertical,50)
                    }
                    .frame(maxWidth: .infinity)
                   
                    
                    Divider()
                    
                    VStack(alignment:.leading, spacing: 20){
                        Text("🌱 Description")
                            .font(.custom("Montserrat-SemiBold", size: 21))
                            .foregroundStyle(.black)
                            .kerning(0.9)
                        Text(plantInfo.description)
                            .font(.custom("Montserrat-SemiBold", size: 15))
                            .foregroundStyle(.black)
                            .kerning(1.2)
                            .padding(10)
                            .frame(width: 360, alignment: .leading)
                            .background(Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .transition(.move(edge: .leading))
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {dismiss()}, label: {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.black)
                                
                        })
                    }
                    
                    ToolbarItem(placement: .principal) {
                        
                        Text("Plant Info")
                            .font(.custom("Montserrat-Medium", size: 21))
                            .padding(10)
                            .foregroundStyle(.black)
                            .kerning(1)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                    }
                })
                .foregroundStyle(.white)
            }else{
                VStack{
                    Text("Loading....")
                        .font(.custom("Montserrat-SemiBold", size: 21))
                        .kerning(1.2)
                }
            }
        }
        .ignoresSafeArea(.all)
        .tint(.black)
    }
}

#Preview {
    PlantInfoVIew(plantInfo: PlantInfo(description: "Hello",imageURL: URL(string: "")))
}
