//
//  MainView.swift
//  Sternik
//
//  Created by MADRAFi on 10/08/2022.
//

import SwiftUI
import StoreKit

struct MainView: View {
    
    @State var selectedTab: Int = 0
    @State var isFullVersion: Bool = false
    @StateObject var store : Store = Store()
    @ObservedObject var data = QuestionsList()
    @AppStorage("Selected_Questions_Module") private var selectedModule: String = "radio-operator.src"
    
//    let fullVersionID = Bundle.main.infoDictionary?["FullVersionProduct"] as? String
    let builtInProduct = Bundle.main.infoDictionary?["BuiltInProduct"] as? String
    
    var body: some View {
        TabView(selection: $selectedTab) {
                CategoryView(data: data, isFullVersion: $isFullVersion)
                    .tabItem {
                        Label("Pytania", systemImage: "filemenu.and.selection")
                    }
                    .tag(0)
            
                ModuleView(isFullVersion: $isFullVersion)
                    .tabItem {
                        Label("Moduły", systemImage: "bag.fill.badge.plus")
                    }
                    .tag(1)
            
                SettingsView()
                    .tabItem {
                        Label("Ustawienia", systemImage: "gearshape.fill")
                    }
                    .tag(2)
                
        }
        .environmentObject(store)
        .environmentObject(data)
        .onAppear() {
//            if selectedModule.isEmpty {
                selectedModule = builtInProduct!
//            }
            data.load(module: selectedModule)
        }
    }
}

struct MainView_Previews: PreviewProvider {    
    static var previews: some View {
        MainView()
    }
}
