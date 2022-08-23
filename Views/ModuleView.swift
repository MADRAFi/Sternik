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
    @Binding var isFullVersion: Bool
    
    let fullVersionID = Bundle.main.infoDictionary?["FullVersionProduct"] as? String
    let builtInProduct = Bundle.main.infoDictionary?["BuiltInProduct"] as? String
    let builtInProductName = Bundle.main.infoDictionary?["BuiltInProductName"] as? String
    let builtInProductDescription = Bundle.main.infoDictionary?["BuiltInProductDescription"] as? String
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    VStack(alignment: .leading) {
                        //                          if !isFullVersion {
                        if !(store.purchasedProducts.contains(where: {$0.id == fullVersionID})) {
                            ADBanner()
                                .frame(width: 320, height: 100, alignment: .center)
                        }
                        SwitchModuleView()
                        HStack {
                            Image("About")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(8)
                                .frame(width: 80, height: 80)
                                .padding(.vertical, 8)
                                .padding(.trailing)
                            
                            VStack(alignment: .leading) {
                                Text(builtInProductName!)
                                    .bold()
                                Text(builtInProductDescription!)
                                    .font(.caption)
                            }
                            Spacer()
                            Button(action: {
                            }) {
                                
                                Text(Image(systemName: "checkmark"))
                                    .bold()
                                    .foregroundColor(Color.primary)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding()
                                    .background(Color("Positive"))
                                
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .disabled(true)
                            
                        }
                        ForEach(store.products) { item in
                            ProductView(product: item)
                            
                        }

                    }
                    VStack(alignment: .trailing) {
                        Spacer()
                        Button(action: {
                            Task {
                                try? await AppStore.sync()
                            }
                        }) {
                            HStack(alignment: .center ) {
                                Text("Przywróć zakupy")
                                    .padding()
                            }
                            
                        }
                        .background(Color("AccentColor"))
                        .foregroundColor(Color.primary)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    }
                    Spacer()
                }
                .padding()
                .navigationTitle("Moduły")
                .navigationBarTitleDisplayMode(.large)
            }
        }
        .navigationViewStyle(.stack)

    }
}

struct ModuleView_Previews: PreviewProvider {
    
    static var previews: some View {

        ModuleView(isFullVersion: .constant(true))
    }
}
