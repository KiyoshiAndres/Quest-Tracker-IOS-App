//
//  Debugger.swift
//  QuestInterface
//
//  Created by Kiyoshi Takeuchi on 2021/11/21.
//

import SwiftUI

struct Debugger: View {
    @EnvironmentObject var debuggerViewModel: mainViewModel
    
    var body: some View {
        
        
        VStack {
            ScrollView {
                
                ScrollView {
                    
                    ForEach(debuggerViewModel.quests) { quest in
                         MissionRow(completed: quest.completed, missionName: quest.name)
                    
                    }
                }.onAppear(perform: { debuggerViewModel.getAbsoluteAllQuests() })
            }
            
            Button(action: { debuggerViewModel.deleteAbsoluteAllBunches()
                debuggerViewModel.getAbsoluteAllBunches()
                debuggerViewModel.getAbsoluteAllQuests()
            }, label:  { Text("Clear Bunches") })
            
            Button(action: { debuggerViewModel.deleteAllQuests()
                debuggerViewModel.getAbsoluteAllQuests()
            }, label:  { Text("Clear Quests") })
        }
    }
}

struct Debugger_Previews: PreviewProvider {
    static var previews: some View {
        Debugger().environmentObject(mainViewModel())
    }
}
