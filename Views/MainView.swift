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
//    @State var isFullVersion: Bool = false
    @StateObject var store : Store = Store()
    @ObservedObject var data = QuestionsList()
    @AppStorage("Selected_Questions_Module") private var selectedModule: String = ""
    
//    let fullVersionID = Bundle.main.infoDictionary?["FullVersionProduct"] as? String
    let builtInProduct = Bundle.main.infoDictionary?["BuiltInProduct"] as? String
    
    var body: some View {
        TabView(selection: $selectedTab) {
//                CategoryView(isFullVersion: $isFullVersion)
                CategoryView()
                    .tabItem {
                        Label("Pytania", systemImage: "filemenu.and.selection")
                            .font(Font.system(.largeTitle).bold())
                    }
                    .tag(0)
            
//                ModuleView(isFullVersion: $isFullVersion)
                ModuleView()
                    .tabItem {
                        Label("Moduły", systemImage: "bag.fill.badge.plus")
                            .font(Font.system(.largeTitle).bold())

                    }
                    .tag(1)
            
                SettingsView()
                    .tabItem {
                        Label("Ustawienia", systemImage: "gearshape.fill")
                            .font(Font.system(.largeTitle).bold())

                    }
                    .tag(2)
                
        }
        .environmentObject(store)
        .environmentObject(data)
        .onAppear() {
            if selectedModule.isEmpty {
                selectedModule = builtInProduct!
            }
            data.load(module: selectedModule)
            
        }
    }
}

struct MainView_Previews: PreviewProvider {    
    static var previews: some View {
        MainView()
    }
}
