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
//    let fullVersionID = Bundle.main.infoDictionary?["FullVersionProduct"] as? String
   
    
    func checkFullVersion() {
        let fullVersionID = Bundle.main.infoDictionary?["FullVersionProduct"] as? String
        Task {
            isFullVersion = ((try? await store.isPurchased(fullVersionID!)) != nil)
        }
    }
    var body: some View {
        TabView(selection: $selectedTab) {
//                CategoryView(data: data, isFullVersion: $isFullVersion)
                CategoryView(data: data, isFullVersion: $isFullVersion)
                .tabItem {
                    Label("Pytania", systemImage: "filemenu.and.selection")
                }
                .tag(0)
            
                ModuleView(isFullVersion: $isFullVersion)
                .tabItem {
                    Label("Moduły", systemImage: "questionmark.app.fill")
                }
                .tag(1)
            
                SettingsView()
                    .tabItem {
                        Label("Ustawienia", systemImage: "gearshape.fill")
                    }
                    .tag(2)
                
        }
        .environmentObject(store)
        .onAppear() {
            checkFullVersion()
        }
    }
}

struct MainView_Previews: PreviewProvider {    
    static var previews: some View {
        MainView()
    }
}
