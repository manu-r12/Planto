
import SwiftUI
import PhotosUI
struct AddPlantVIew: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    @State var textInput = ""
    @State var amount = ""
    @State var markInput = ""
    @State var selectedDate = Date()
    @ObservedObject var viewModel = AddPlantController.shared
    @EnvironmentObject var parentVIewModel: HomeViewModel
    
    @State private var isImagePickerPresented: Bool = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        VStack(spacing: 20){
            
            //TODO: ---Camera and Photos Picker Section---
            VStack{
                if viewModel.selectedImage != nil{
                    Image(uiImage: viewModel.selectedImage!)
                                    .resizable()
                                    .scaledToFill()
                }else{
                    
                    Button {
                        isImagePickerPresented.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "camera.fill")
                            Text("Camera")
                                .font(.custom("Montserrat-Medium", size: 19))
                                .kerning(1.3)
                        }
                        .frame(width: 280, height: 50)
                        .background(Color("green3"))
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                    }

                    
                 
                    //Photos Picker Button
                    PhotosPicker(selection: $viewModel.pickedItem) {
                        HStack {
                            Image(systemName: "photo.fill")
                            Text("Photos")
                                .font(.custom("Montserrat-Medium", size: 19))
                                .kerning(1.3)
                        }
                        .frame(width: 280, height: 50)
                        .background(Color("green1"))
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                    }
                }
                
            }
            .frame(width: 400, height: 300)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            
            //TODO: ---Form Section---
            VStack(spacing: 40){
                Text("Add a reminder for a new Plant")
                    .font(.custom("Montserrat-Medium", size: 17))
                    .kerning(1)
                //TODO: Name of the plant
                VStack(alignment: .leading){
                    Text("Plant Name🍀")
                        .font(.custom("Montserrat-Medium", size: 17))
                        .kerning(1)
                        .padding(.horizontal)
                    ZStack(alignment: .bottom){
                        TextField("", text: $textInput)
                            .font(.custom("Montserrat-SemiBold", size: 17))
                            .background()
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding(.vertical, 5)
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal)
                }
                //TODO: Date Picker
                VStack(alignment: .leading){
                    DatePicker("Select Time -", selection: $selectedDate, displayedComponents: .hourAndMinute)
                        .font(.custom("Montserrat-Medium", size: 17))
                        .kerning(1)
                }
                .padding(.horizontal)
                //TODO: Amount of plants input
                VStack(alignment: .leading){
                    Text("How many do you have🪴")
                        .font(.custom("Montserrat-Medium", size: 17))
                        .kerning(1)
                        .padding(.horizontal)
                    ZStack(alignment: .bottom){
                        TextField("", text: $amount)
                            .font(.custom("Montserrat-SemiBold", size: 17))
                            .background()
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding(.vertical, 5)
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal)
                }
                
                //TODO: Mark input
                
                VStack(alignment: .leading){
                    Text("Mark (optional)📍")
                        .font(.custom("Montserrat-Medium", size: 17))
                        .kerning(1)
                        .padding(.horizontal)
                    ZStack(alignment: .bottom){
                        TextField("near my desk", text: $markInput)
                            .font(.custom("Montserrat-SemiBold", size: 17))
                            .background()
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding(.vertical, 5)
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal)
                }
                
                
                HStack {
                    //TODO: Cancel Button
                    Button {
                        viewModel.selectedImage = nil
                        dismiss()
                    } label: {
                        HStack {
                            Text("Cancel")
                                .font(.custom("Montserrat-Bold", size: 19))
                                .kerning(1.3)
                        }
                        .frame(width: 150, height: 50)
                        .background(Color(.black))
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                    }
                    //TODO: Done Button
                    
                    Button {
                        viewModel.addReminders(withName: textInput,withAmount: amount, withTime: selectedDate,  withMark: markInput , withContext: managedObjContext)
                        viewModel.selectedImage = nil
                        parentVIewModel.loadtheData(withContext: managedObjContext)
                        dismiss()
                        
                    } label: {
                        HStack {
                            Text("Done")
                                .font(.custom("Montserrat-Bold", size: 19))
                                .kerning(1.3)
                        }
                        .frame(width: 150, height: 50)
                        .background(Color("green2"))
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                    }
                }
                
            }
            
            Spacer()
        }
        .fullScreenCover(isPresented: $isImagePickerPresented, content: {
            ImagePicker()
                .edgesIgnoringSafeArea(.all)
        })
        .ignoresSafeArea()
    }
}

#Preview {
    AddPlantVIew()
}
