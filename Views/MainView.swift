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
    @EnvironmentObject var store : Store
    @ObservedObject var data = Category.repository
    @AppStorage("Selected_Questions_Module") private var selectedModule: String = ""

    let builtInProduct = Bundle.main.infoDictionary?["BuiltInProduct"] as? String
    
    var body: some View {
        TabView(selection: $selectedTab) {
                CategoryView()
                    .tabItem {
                        Label("Pytania", systemImage: "filemenu.and.selection")
//                            .font(Font.system(.largeTitle).bold())
                    }
                    .tag(0)
            
                ModuleView()
                    .tabItem {
                        Label("Moduły", systemImage: "bag.fill.badge.plus")
//                            .font(Font.system(.largeTitle).bold())

                    }
                    .tag(1)
            
                SettingsView()
                    .tabItem {
                        Label("Ustawienia", systemImage: "gearshape.fill")
//                            .font(Font.system(.largeTitle).bold())

                    }
                    .tag(2)
                
        }
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
            .environmentObject(Store())
    }
}
