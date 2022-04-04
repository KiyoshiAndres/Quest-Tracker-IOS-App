//
//  MissionDetails.swift
//  QuestInterface
//
//  Created by Kiyoshi Takeuchi on 11/18/21.
//

import SwiftUI
import CoreData

struct MissionDetails: View {
    @State private var text = ""
    @State private var showAlert = false
    @EnvironmentObject var missionDetailsViewModel: mainViewModel
    var objectId: NSManagedObjectID
    var type: String
    
    var body: some View {
        ZStack {
            LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)), location: -0.3),
                            .init(color: Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)), location: 0.5),
                            .init(color: Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)), location: 1.6)
                        ]),
                        startPoint: .bottomTrailing,
                        endPoint: .leading
                    )
                            .ignoresSafeArea()
            
            VStack{
            Text("Task Details")
                .font(.custom("Futura", size: 25))
                .fontWeight(.heavy)
                .foregroundColor(.red)
                .padding([.leading, .bottom, .trailing])
                
                ScrollView {
                    if missionDetailsViewModel.details != [] {
                        ForEach(missionDetailsViewModel.details) { detail in
                            
                            HStack {
                                Text(detail.name).font(.headline).foregroundColor(Color(#colorLiteral(red: 0.4, green: 0.9, blue: 0.8, alpha: 1))).padding()
                                Spacer()
                                Button(action: { CoreDataStack.getDetailById(id: detail.id)!.completed = !CoreDataStack.getDetailById(id: detail.id)!.completed
                                    missionDetailsViewModel.getDetailsFromQuest(objectId: objectId)
                                    if missionDetailsViewModel.details.allSatisfy({ $0.completed == true }) {
                                        CoreDataStack.getQuestById(id: objectId)!.completed = true
                                    }
                                    else {
                                        CoreDataStack.getQuestById(id: objectId)!.completed = false
                                    }
                                    missionDetailsViewModel.getQuestsFromBunch(type: type)
                                    CoreDataStack.save()
                                    missionDetailsViewModel.getDetailsFromQuest(objectId: objectId)
                                }, label: {
                                    
                                    ZStack{
                                        Image(systemName: "square")
                                            .font(.title)
                                            .foregroundColor(.black)
                                        Image(systemName: "square.fill")
                                            .opacity(detail.completed ? 1 : 0)
                                            .foregroundColor(.green)
                                    }
                                }
                                ).padding()
                            }
                        
                            
                            
                        }
                    }
                    else {
                        HStack {
                            Text("Completed?").font(.headline).foregroundColor(Color(#colorLiteral(red: 0.4, green: 0.9, blue: 0.8, alpha: 1))).padding()
                            Spacer()
                            Button(action: {
                                CoreDataStack.getQuestById(id: objectId)!.completed = !CoreDataStack.getQuestById(id: objectId)!.completed
                                CoreDataStack.save()
                                missionDetailsViewModel.getQuestsFromBunch(type: type)
                                missionDetailsViewModel.getDetailsFromQuest(objectId: objectId)
                            }, label: {
                                
                                ZStack{
                                    Image(systemName: "square")
                                        .font(.title)
                                        .foregroundColor(.black)
                                    Image(systemName: "square.fill")
                                        .opacity(CoreDataStack.getQuestById(id: objectId)!.completed ? 1 : 0)
                                        .foregroundColor(.green)
                                }
                            }
                            ).padding()
                        }
                    }
                }
            Spacer()
                
                Button(action: { self.showAlert = true }, label: { createDetail(buttonText: "Add New Detail") }).background(AlertControl(textString: self.$text, show: self.$showAlert,
                                                                                                                                         title: "New Detail", message: "Enter detail here", getTasks: { missionDetailsViewModel.getDetailsFromQuest(objectId: objectId)
                    if CoreDataStack.getQuestById(id: objectId)!.completed {
                        CoreDataStack.getQuestById(id: objectId)!.completed = false
                    }
                }, addTask:
                                                                                                                                { (s1: String, detailTitle: String) -> () in
                    let detail = Detail(context: CoreDataStack.viewContext)
                    detail.title = detailTitle
                    detail.completed = false
                    detail.quest = CoreDataStack.getQuestById(id: objectId)
                    CoreDataStack.save()
                }
                                                                                                                                         , addingTaskOrDetails: "details"))
               
              
            }
            
            
        }.onAppear(perform: { missionDetailsViewModel.getDetailsFromQuest(objectId: objectId) })
    }
}

struct SubMissionRow: View {
    @State var completed: Bool = false
    var missionName: String
    var body: some View {
        HStack {
            Text(missionName).font(.headline).foregroundColor(Color(#colorLiteral(red: 0.4, green: 0.9, blue: 0.8, alpha: 1))).padding()
            Spacer()
            Button(action: { completed = !completed }, label: {
                
                ZStack{
                    Image(systemName: "square")
                        .font(.title)
                        .foregroundColor(.black)
                    Image(systemName: "square.fill")
                        .opacity(completed ? 1 : 0)
                        .foregroundColor(.green)
                }
            }
            ).padding()
        }
        
    }
}

struct createDetail: View {
    var buttonText: String

    var body: some View {
       
        
            Text(buttonText)
                .fontWeight(.heavy)
                .foregroundColor(Color.blue)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .strokeBorder(lineWidth: 3)
                        .foregroundColor(.blue)
                        .shadow(color: .blue, radius: 5)
                ).padding()
           
    }
}





/*


struct MissionDetails_Previews: PreviewProvider {
    static var previews: some View {
        MissionDetails().environmentObject(mainViewModel())
    }
}
*/
