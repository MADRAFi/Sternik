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
    @ObservedObject var data = Category.repository
    @AppStorage("Selected_Questions_Module") private var selectedModule: String = ""
    
    let fullVersionID = Bundle.main.infoDictionary?["FullVersionProduct"] as? String ?? ""
    let builtInProduct = Bundle.main.infoDictionary?["BuiltInProduct"] as? String ?? ""
    let builtInProductName = Bundle.main.infoDictionary?["BuiltInProductName"] as? String ?? ""
    
    var body: some View {
        VStack {
            HStack {
                /// bugfix for iOS difference between version 16 and olders
                if #unavailable( iOS 16 ) {
                    Text("Wybrany moduł")
                    Spacer()
                }
                Picker("Wybrany moduł", selection: $selectedModule) {
                    Text(builtInProductName)
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
                .pickerStyle(.menu)
            }
            
        }
        .padding()
        .onAppear() {
            if selectedModule.isEmpty {
                selectedModule = builtInProduct
            }
        }
    }
}

struct SwitchModuleView_Previews: PreviewProvider {
    
    static var previews: some View {
        SwitchModuleView()
            .environmentObject(Store())
    }
}
