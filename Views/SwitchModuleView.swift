//
//  SwitchModuleView.swift
//  Sternik
//
//  Created by MADRAFi on 22/08/2022.
//

import SwiftUI
import StoreKit

struct SwitchModuleView: View {
    
    @EnvironmentObject var store: Store
    @EnvironmentObject var data : QuestionsList
    @AppStorage("Selected_Questions_Module") private var selectedModule: String = ""
    
    let fullVersionID = Bundle.main.infoDictionary?["FullVersionProduct"] as? String
    let builtInProduct = Bundle.main.infoDictionary?["BuiltInProduct"] as? String
    let builtInProductName = Bundle.main.infoDictionary?["BuiltInProductName"] as? String
    
    var body: some View {
        VStack {
            HStack {
                Text("Wybrany moduł")
                Spacer()
                Picker(selection: $selectedModule, label: Text("Wybierz zestaw pytań")) {
                    Text(builtInProductName!)
                        .tag(builtInProduct!)
                    ForEach(store.purchasedProducts) { product in
                        if product.id != fullVersionID {
                            Text(product.displayName)
                                .tag(product)
                        }
                    }
                    
                    
                }
                .onChange(of: selectedModule) { newValue in
                    data.load(module: selectedModule)
                }
                //                .pickerStyle(.inline)
            }
            
            
        }
        .padding()
        .onAppear() {
            if selectedModule.isEmpty {
                selectedModule = builtInProduct!
            }
        }
    }
}

struct SwitchModuleView_Previews: PreviewProvider {
    
    static var previews: some View {
        SwitchModuleView()
    }
}
