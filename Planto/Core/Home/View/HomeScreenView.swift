import SwiftUI
import CoreData

struct HomeScreenView: View {
    
    //SwiftUI enviroments
    @Environment(\.managedObjectContext) var managedObjContext
    @ObservedObject var viewModel = HomeViewModel.shared
    @State private var isSheetOpen = false
    @State var searchField = ""
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    
    var body: some View {
        ZStack{
            Color(.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            NavigationStack{
                HStack {
                    Text("Planto")
                        .font(.title)
                        .fontWeight(.bold)
                        .kerning(1.1)
                    Image(systemName: "leaf.fill")
                        .foregroundStyle(.green)
                }
                .onTapGesture {
                    print("view model remnder ------> ",viewModel.reminders)
                }
                
                VStack(){
                    
                    HStack{
                        Image(systemName: "magnifyingglass")
                        TextField("", text: $searchField)
                            .font(.custom("Montserrat-Regular", size: 13))
                            
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                }
                .padding(.horizontal)
                
                ScrollView{
                      
                    LazyVStack(spacing: 18){
                        ForEach(viewModel.reminders){reminder in
                            NavigationLink(value: reminder) {
                                PlantInfoBoxView_List(reminder: reminder)
                                    .tint(.black)
                            }
                        }
                    }
                }
                .navigationDestination(for: Reminder.self) { reminder in
                    PlantReminderDetailsVIew(reminder: reminder)
                        .navigationBarBackButtonHidden(true)
                }
            }
            
            
            ZStack(alignment: .bottomTrailing){
                Button(action: {isSheetOpen.toggle()}, label: {
                    Image(systemName: "plus")
                        .foregroundStyle(.white)
                        .background(Circle().fill(Color("green3"))
                            .frame(width: 62, height: 62)
                        )
                        .padding(.vertical, 50)
                        .padding(.horizontal, 40)
                    
                })
            }
            .padding(.trailing)
            .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .bottomTrailing)
        }
        .fullScreenCover(isPresented: $isSheetOpen, content: {
            AddPlantVIew()
                .environmentObject(HomeViewModel())
            
        })
    }
}

#Preview {
    HomeScreenView()
}
