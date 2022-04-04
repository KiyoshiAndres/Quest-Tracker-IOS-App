//
//  ArchiveView.swift
//  QuestInterface
//
//  Created by Kiyoshi Takeuchi on 11/18/21.
//

import SwiftUI

struct ArchiveView: View {
    @State private var presentAlert = false
    @EnvironmentObject var archiveViewModel: mainViewModel
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
            Text("Archive")
                .font(.custom("Futura", size: 25))
                .fontWeight(.heavy)
                .foregroundColor(.red)
                .padding([.leading, .bottom, .trailing])
                
                
                ScrollView {
                    
                    ForEach(archiveViewModel.quests.reversed()) { quest in
                        ArchiveRow(completed: quest.completed, missionName: quest.name, color:
                                    archiveViewModel.colorChooser(type: archiveViewModel.getBunchTypeFromQuest(quest: quest)), experience: archiveViewModel.experienceChooser(type: archiveViewModel.getBunchTypeFromQuest(quest: quest))
                                    )
                    
                    }
                }.onAppear(perform: { archiveViewModel.getAbsoluteAllQuests() })
                
                Button(action: { presentAlert = true }, label: { resetButton(buttonText: "Clear Archive") } )
            }.alert(isPresented: $presentAlert) {
                Alert(
                    title: Text("Warning"),
                    message: Text("This will clear the archive, and it is irreversible."),
                    primaryButton: .destructive(Text("Clear"), action: {
                        archiveViewModel.deleteAbsoluteAllBunches()
                            archiveViewModel.getAbsoluteAllBunches()
                            archiveViewModel.getAbsoluteAllQuests()
                    }),
                    secondaryButton: .default(Text("Cancel"), action: {
                        
                    })
                )
            }
            
        }
    }
}

struct ArchiveRow: View {
    var completed: Bool
    var missionName: String
    var color: Color
    var experience: Int
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .blur(radius: 4)
                .opacity(0.05)
                .foregroundColor(.black)
                .aspectRatio(6, contentMode: .fit)
            HStack {
                Text(missionName)
                    .font(.headline)
                    .foregroundColor(Color(#colorLiteral(red: 0.4, green: 0.9, blue: 0.8, alpha: 1)))
                    .padding()
                    .shadow(color: color, radius: 6)
                Spacer()
                
                Text("Exp: \(experience)")
                    .font(.headline)
                    .foregroundColor(color)
                    .padding()
                    .shadow(color: color, radius: 6)
               
                ZStack{
                    Image(systemName: "square")
                        .font(.title)
                        .foregroundColor(.black)
                    Image(systemName: "square.fill")
                        .opacity(completed ? 1 : 0)
                        .foregroundColor(.green)
                    Image(systemName: "square.fill")
                        .opacity(completed ? 0 : 1)
                        .foregroundColor(.red)
                }.padding()
                
            }
        }
        
    }
}


struct resetButton: View {
    var buttonText: String

    var body: some View {
       
            Text(buttonText)
                .fontWeight(.heavy)
                .foregroundColor(Color.red)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .strokeBorder(lineWidth: 3)
                        .foregroundColor(.red)
                        .shadow(color: .red, radius: 5)
                ).padding()
           
    }
}





struct ArchiveView_Previews: PreviewProvider {
    static var previews: some View {
        ArchiveView()
    }
}
