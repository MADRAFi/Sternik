//
//  MainView.swift
//  Sternik
//
//  Created by MADRAFi on 10/08/2022.
//

import SwiftUI

struct MainView: View {
    
    @State var selectedTab: Int = 0

    @ObservedObject var data = QuestionsList()

    
    var body: some View {
        TabView(selection: $selectedTab) {
                CategoryView(data: data)
                .tabItem {
                    Label("Pytania", systemImage: "filemenu.and.selection")
                }
                .tag(0)
            
//                ContentView()
//                .tabItem {
//                    Label("Moduły", systemImage: "questionmark.app.fill")
//                }
//                .tag(1)
            
            
                SettingsView()
                    .tabItem {
                        Label("Ustawienia", systemImage: "gearshape.fill")
                    }
                    .tag(2)
                
        }
        

    }
}

struct MainView_Previews: PreviewProvider {    
    static var previews: some View {
        MainView()
    }
}
