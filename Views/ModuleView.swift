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
    @Binding var isFullVersion: Bool
    
    let fullVersionID = Bundle.main.infoDictionary?["FullVersionProduct"] as? String

    var body: some View {
        
        NavigationView {
                        VStack(alignment: .trailing) {
                            ForEach(store.products) { item in
                                ProductView(product: item)
                                
                            }

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
    //                        .clipShape(Capsule())
                            .clipShape(RoundedRectangle(cornerRadius: 10)) 
                    
        //                    if !isFullVersion {
                            if !(store.purchasedProducts.contains(where: {$0.id == fullVersionID})) {
                                ADBanner()
                                    .frame(width: 320, height: 100, alignment: .center)
                            }
                            Spacer()
                        }
                        .padding()
                        .navigationTitle("Moduły")
                        .navigationBarTitleDisplayMode(.large)
        }
        .navigationViewStyle(.stack)
    }
}

struct ModuleView_Previews: PreviewProvider {
    
    static var previews: some View {

        ModuleView(isFullVersion: .constant(true))
    }
}
