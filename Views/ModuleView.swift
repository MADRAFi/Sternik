//
//  ModuleView.swift
//  Sternik
//
//  Created by MADRAFi on 20/08/2022.
//

import SwiftUI
import StoreKit

struct ModuleView: View {
    

    @EnvironmentObject var store: Store
    @EnvironmentObject var data: QuestionsList
//    @Binding var isFullVersion: Bool
    
    let fullVersionID = Bundle.main.infoDictionary?["FullVersionProduct"] as? String ?? ""
    let builtInProduct = Bundle.main.infoDictionary?["BuiltInProduct"] as? String ?? ""
    let builtInProductName = Bundle.main.infoDictionary?["BuiltInProductName"] as? String ?? ""
    let builtInProductDescription = Bundle.main.infoDictionary?["BuiltInProductDescription"] as? String ?? ""
    
    
    var productButton: some View {
        Button(action: {}) {
            ownedButton
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    func displayProduct(id: String, name: String, description: String) -> some View {
        
        return HStack {
            Image(id)
                .cornerRadius(8)
                .padding(.leading, 15)
            VStack(alignment: .leading) {
                Text(name)
                    .font(.body)
                Text(description)
                    .font(.caption2)
            }
            Spacer()
            productButton
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    if !(store.purchasedProducts.contains(where: {$0.id == fullVersionID})) {
                        ADBanner()
                            .frame(width: 320, height: 100, alignment: .center)
                    }
                    SwitchModuleView()
                }
                ScrollView {
                    VStack {
                        VStack(alignment: .leading) {
                            displayProduct(id: builtInProduct, name: builtInProductName, description: builtInProductDescription)
                            ForEach(store.products) { item in
                                ProductView(product: item)
                            }

                        }
                        HStack {
                            Spacer()
                            Button(action: {
                                Task {
                                    try? await AppStore.sync()
                                }
                            }) {
                                HStack {
                                    Text("Przywróć zakupy")
                                        .font(.body)
//                                        .padding(.vertical, 8)
                                        .padding(.horizontal)
                                }
                                
                            }
//                            .background(Color("AccentColor"))
//                            .foregroundColor(Color.primary)
//                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                            
                        }
//                        Spacer()
                    }
//                    .padding()
                    .navigationTitle("Moduły")
                    .navigationBarTitleDisplayMode(.large)
                }
            }
        }
        .navigationViewStyle(.stack)

    }
}

struct ModuleView_Previews: PreviewProvider {
    
    static var previews: some View {

//        ModuleView(isFullVersion: .constant(true))
            ModuleView()
    }
}
