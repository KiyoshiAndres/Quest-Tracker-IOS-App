//
//  QuestView.swift
//  QuestInterface
//
//  Created by Kiyoshi Takeuchi on 11/18/21.
//

import SwiftUI

struct QuestView: View {
    var body: some View {
        ZStack {
            Color(red: 0.92, green: 0.69, blue: 0.5).edgesIgnoringSafeArea(.all)
            Color(red: 0.97, green: 0.85, blue: 0.7)
            VStack{
            Text("Today's Quests")
                .font(.custom("Bradley Hand", size: 25))
                .padding()
            QuestRow()
                
            Spacer()
            }
        }
    }
}

struct QuestRow: View {
    @State var completed: Bool = false
    var body: some View {
        HStack {
            Text("Study").padding()
            Spacer()
            Button(action: { completed = !completed }, label: {
                
                ZStack{
                    Image(systemName: "square")
                        .font(.title)
                        .foregroundColor(.black)
                    Image(systemName: "checkmark")
                        .font(.largeTitle)
                        .opacity(completed ? 1 : 0)
                        .foregroundColor(.red)
                }
            }
            ).padding()
        }
        
    }
}


struct QuestView_Previews: PreviewProvider {
    static var previews: some View {
        QuestView()
    }
}
