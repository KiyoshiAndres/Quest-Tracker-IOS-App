//
//  ContentView.swift
//  QuestInterface
//
//  Created by Kiyoshi Takeuchi on 11/16/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            MainScreenView()
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("Back")
                .navigationBarHidden(true)
        }.accentColor( .green)
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
