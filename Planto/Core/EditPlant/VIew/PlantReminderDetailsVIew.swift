import SwiftUI
import CoreML
import CoreImage
import SwiftyJSON
import URLImage

struct PlantReminderDetailsVIew: View {
    @Environment(\.managedObjectContext) var mangedObjContext
    @ObservedObject var viewModel = EditViewModel.shared
    let reminder: FetchedResults<Reminder>.Element
    @Environment(\.dismiss) var dismissView
    @State var showThePlantInfoView = false
    @State private var isPresented =  false
    
    var isShow: Bool{
        if viewModel.wikiData.isEmpty
        {
            return false
        }else{
            return true
        }}
    
    @State var isFetching = false
    
    //TODO: Date Formaatter Function
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: date)
    }
    
    var body: some View {
        
        ZStack {
            VStack{
                
                ZStack(alignment:.topLeading){
                    if let image = reminder.image{
                        Image(uiImage:image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 395,height: 320)
                    }else{
                        Image("p1")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 395,height: 320)
                    }
                    
                    
                    Button(action: {
                     
                        WikiApiManagar.shared.flowerDataJson = []
                        viewModel.wikiData = []
                        mangedObjContext.refreshAllObjects()
                        dismissView()
                        
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.black)
                            .background(Circle().fill(.white)
                                .frame(width: 42, height: 42)
                            )
                            .padding(.vertical, 60)
                            .padding(.horizontal, 50)
                        
                    })
                    
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                
                ScrollView(showsIndicators: false){
                    VStack(alignment:.center,spacing: 20){
                        //TODO: Get Info Button
                        VStack {
                            Button(action: {
                                withAnimation(.smooth) {
                                    isFetching = true
                                    if let ciImage = CIImage(image: reminder.image!) {
                                        print("Getting the model")
                                        let _ = DetectionModel.shared.detect(image: ciImage)
                                        showThePlantInfoView.toggle()
                                    } else {
                                        print("Failed to convert UIImage to CIImage.")
                                    }
                                }
                            }, label: {
                                HStack {
                                    Image(systemName: "camera.macro.circle.fill")
                                        .foregroundStyle(.green)
                                    if isShow{
                                        Text("Result")
                                            .kerning(1)
                                    }else{
                                        Text(!isFetching ? "Get the information about your plant" : "Fetching")
                                            .kerning(1)
                                    }
                                }
                                .padding()
                            })
                        }
                        .frame(width: 360)
                        .foregroundStyle(.white)
                        .background(.black)
                        .font(.custom("Montserrat-Regular", size: 14))
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .transition(.move(edge: .leading))
                        .animation(.spring(), value: isShow)
                        
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        //TODO: Plant Name
                        VStack(alignment: .leading){
                            HStack {
                                Text("🪴")
                                
                                Text(reminder.name ?? "Some Plant")
                                    .font(.custom("Montserrat-Medium", size: 22))
                                    .kerning(1)
                                
                            }
                        }
                        
                        
                        //TODO: Reminder Informaiton
                        VStack(spacing: 35){
                            
                            VStack(alignment: .leading,spacing: 20){
                                Text("Reminder TIme")
                                    .font(.custom("Montserrat-Medium", size: 19))
                                    .kerning(1)
                                HStack {
                                    Text("⏰")
                                    Text(formatDate(date: reminder.time ?? Date.now))
                                }
                                .font(.custom("Montserrat-Medium", size: 16))
                                .padding(.horizontal)
                                .kerning(1.2)
                                .frame(width: 360, height: 50, alignment: .leading)
                                .background(Color(.systemGray5))
                                .clipShape(RoundedRectangle(cornerRadius: 18))
                            }
                            
                            VStack(alignment: .leading,spacing: 20){
                                Text("Additional Info")
                                    .font(.custom("Montserrat-Medium", size: 19))
                                    .kerning(1)
                                HStack {
                                    Text("📍")
                                    Text(reminder.mark ?? "in my house")
                                }
                                .padding(.horizontal)
                                .frame(width: 360, height: 50, alignment: .leading)
                                .background(Color(.systemGray5))
                                .clipShape(RoundedRectangle(cornerRadius: 18))
                                
                                HStack {
                                    Text("🌱 You Have")
                                    Text(reminder.amount ?? "1")
                                    Text("Plants")
                                }
                                .padding(.horizontal)
                                .frame(width: 360, height: 50, alignment: .leading)
                                .background(Color(.systemGray5))
                                .clipShape(RoundedRectangle(cornerRadius: 18))
                            }
                            .kerning(1.2)
                            .font(.custom("Montserrat-Medium", size: 16))
                        }
                        
                        
                        VStack {
                            HStack(alignment: .center,spacing: 30){
                                // so once we delete we wanna go back
                                Button(action: {
                                    ReminderContainer.shared.deleteReminder(theReminder: reminder)
                                    ReminderContainer.shared.saveReminders(context: mangedObjContext)
                                    dismissView()
                                    HomeViewModel.shared.loadtheData(withContext: mangedObjContext)
                                   
                                }, label: {
                                    Text("Delete")
                                        .font(.custom("Montserrat-Medium", size: 16))
                                        .kerning(0.8)
                                        .foregroundStyle(.white)
                                        .frame(width: 130, height: 45)
                                        .background(.black)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                    
                                    
                                    
                                })
                                
                                Button(action: {
                                    isPresented.toggle()
                                }, label: {
                                    Text("Edit")
                                        .font(.custom("Montserrat-Medium", size: 16))
                                        .kerning(0.8)
                                        .foregroundStyle(.white)
                                        .frame(width: 130, height: 45)
                                        .background(.black)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                    
                                })
                            }
                            
                        }
                        .padding(.vertical)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
                        
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        
                    }
                }
                
                .padding(.horizontal)
                .frame(maxHeight: .infinity, alignment: .leading)
            }
            
        }
        .fullScreenCover(isPresented: $isPresented, onDismiss: {
       
        } , content: {
            UpdatePlantView(reminder: reminder)
        })
        .ignoresSafeArea(.all)
        .fullScreenCover(isPresented: $showThePlantInfoView) {
            
            WikiApiManagar.shared.flowerDataJson = []
            viewModel.wikiData = []
            isFetching = false
            
        } content: {
            PlantInfoVIew(plantInfo: viewModel.plantInfo!)
                .presentationBackground(.ultraThinMaterial)
            
            
        }
        
    }
}


struct PlantReminderDetailsVIew_PreviewProvider: PreviewProvider {
    
    static var previews: some View {
        let viewContext = ReminderContainer.shared.container.viewContext
        let previewItem = Reminder(context: viewContext)
        previewItem.name = "Heron Ballon"
        previewItem.message = "It is time"
        previewItem.image = UIImage(named: "p1")
        previewItem.mark = "At my desk"
        previewItem.time = Date.now
        previewItem.amount =  "1"
        return PlantReminderDetailsVIew(reminder: previewItem)
    }
}
