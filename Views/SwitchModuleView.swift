//
//  SwitchModuleView.swift
//  Sternik
//
//  Created by MADRAFi on 22/08/2022.
//

import SwiftUI
import StoreKit

struct SwitchModuleView: View {

    let fullVersionID = Bundle.main.infoDictionary?["FullVersionProduct"] as? String
    let builtInProduct = Bundle.main.infoDictionary?["BuiltInProduct"] as? String
    
    @EnvironmentObject var store: Store
    @EnvironmentObject var data : QuestionsList
    @AppStorage("Selected_Questions_Module") private var selectedModule: String = "radio-operator.src"

    
    var body: some View {
        VStack(alignment: .leading)  {
            HStack {
                Text("Wybrany moduł")
                Picker(selection: $selectedModule, label: Text("Wybierz zestaw pytań")) {
                    Text("Pytania SRC")
                        .tag(builtInProduct)
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
                //            .pickerStyle(.inline)
//                            .pickerStyle(.wheel)
            }

                
        }
    }
}

struct SwitchModuleView_Previews: PreviewProvider {
    
    static var previews: some View {
        SwitchModuleView()
    }
}
