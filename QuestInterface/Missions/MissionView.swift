//
//  MissionView.swift
//  QuestInterface
//
//  Created by Kiyoshi Takeuchi on 11/18/21.
//

import SwiftUI

struct MissionView: View {
    @State private var text = ""
    @State private var showAlert = false
    @EnvironmentObject var missionViewModel: mainViewModel
    var type: String
    var textTitle: String
    
    
    var body: some View {
        ZStack {
            LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)), location: -0.5),
                            .init(color: Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)), location: 0.40),
                            .init(color: Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)), location: 1.6)
                        ]),
                        startPoint: .trailing,
                        endPoint: .bottomLeading
                    )
                            .ignoresSafeArea()
            
            VStack{
                Text(textTitle)
                .font(.custom("Futura", size: 25))
                .fontWeight(.heavy)
                .foregroundColor(Color(#colorLiteral(red: 0.4, green: 0.9, blue: 0.8, alpha: 1)))
                .padding([.leading, .trailing])
                HStack {
                    Text("Expires ")
                        .foregroundColor(Color(#colorLiteral(red: 0.4, green: 0.9, blue: 0.8, alpha: 1)))
                    Text("\(missionViewModel.dateFormater(date: missionViewModel.activeBunch[0].date, type: type))")
                        .foregroundColor(.orange)
                        .fontWeight(.heavy)
                    
                }
                
               
                ScrollView {
                    
                    
                    
                    
                  
                    ForEach(missionViewModel.quests) { quest in
                        
                        
                            NavigationLink(destination: { MissionDetails(objectId: quest.id, type: type).environmentObject(missionViewModel) }, label: { MissionRow(completed: quest.completed, missionName: quest.name) })
                        
                    
                    }
                    
                }
                
            
            Spacer()
                
                Button(action: { self.showAlert = true
                }, label: { createButton(buttonText: "Create New Task") }).background(AlertControl(textString: self.$text, show: self.$showAlert,
                                                                                                   title: "New Task", message: "Enter task here:", getTasks: { missionViewModel.getQuestsFromBunch(type: type) },
                                
                    addTask: { (s1: String, questTitle: String) -> () in
                        let quest = Quest(context: CoreDataStack.viewContext)
                        quest.title = questTitle
                        quest.completed = false
                        quest.bunch = CoreDataStack.getAllBunches(type: type)[0]
                        CoreDataStack.save()
                    },
                                                                                                   
                    addingTaskOrDetails: "tasks" ))
                
                
            }
        }.onAppear(perform: { missionViewModel.getQuestsFromBunch(type: type) })
        
        
    }
    
}

struct MissionRow: View {
    var completed: Bool
    var missionName: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .blur(radius: 4)
                .opacity(0.05)
                .foregroundColor(.black)
                .aspectRatio(6, contentMode: .fit)
            HStack {
                Text(missionName).font(.headline).foregroundColor(Color(#colorLiteral(red: 0.4, green: 0.9, blue: 0.8, alpha: 1))).padding()
                Spacer()
               
                ZStack{
                    Image(systemName: "square")
                        .font(.title)
                        .foregroundColor(.black)
                    Image(systemName: "square.fill")
                        .opacity(completed ? 1 : 0)
                        .foregroundColor(.green)
                }.padding()
                
            }
        }
        
    }
}

struct createButton: View {
    var buttonText: String

    var body: some View {
       
            Text(buttonText)
                .fontWeight(.heavy)
                .foregroundColor(Color.blue)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .overlay(
                    
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .strokeBorder(lineWidth: 3)
                        .foregroundColor(.blue)
                        .shadow(color: .blue, radius: 5)
                    }
                    
                ).padding()
           
    }
}













struct MissionView_Previews: PreviewProvider {
    static var previews: some View {
        MissionView(type: "Daily Tasks", textTitle: "Today's Quests").environmentObject(mainViewModel())
    }
}

