//
//  ModuleView.swift
//  Sternik
//
//  Created by MADRAFi on 20/08/2022.
//

import SwiftUI
import StoreKit

struct ModuleViewTest: View {
    

//    @EnvironmentObject var store: Store
//    @EnvironmentObject var data: QuestionsList
//    @Binding var isFullVersion: Bool
    
//    let fullVersionID = Bundle.main.infoDictionary?["FullVersionProduct"] as? String
//    let builtInProduct = Bundle.main.infoDictionary?["BuiltInProduct"] as? String
//    let builtInProductName = Bundle.main.infoDictionary?["BuiltInProductName"] as? String
//    let builtInProductDescription = Bundle.main.infoDictionary?["BuiltInProductDescription"] as? String
    
    fileprivate func buitInProductView() -> some View {
        return HStack {
            Image("radio_operator.src")

                .cornerRadius(8)
//                .frame(width: 80, height: 80)
                .padding(.vertical, 8)
                .padding(.horizontal)
            
            VStack(alignment: .leading) {
                Text("Pytania SRC")
                    .bold()
                Text("Zestaw pytań operatora SRC")
                    .font(.caption)
            }
            Spacer()
            ownedButton_test
                .padding(.vertical, 8)
                .padding(.horizontal)
            
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
//                    SwitchModuleView()
                }
                ScrollView {
                    VStack {
                        VStack(alignment: .leading) {

                            buitInProductView()
//                            ForEach(store.products) { item in
//                                ProductView(product: item)
//
//                            }

                        }
                        VStack(alignment: .trailing) {
                            Spacer()
                            Button(action: {
                                Task {
//                                    try? await AppStore.sync()
                                }
                            }) {
                                HStack(alignment: .center ) {
                                    Text("Przywróć zakupy")
//                                        .padding()
                                        .padding(.vertical, 8)
                                        .padding(.horizontal)
                                }
                                
                            }
                            .background(Color("AccentColor"))
                            .foregroundColor(Color.primary)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                        }
                        Spacer()
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

var ownedButton_test: some View {
    Button(action: {}) {
        Text(Image(systemName: "checkmark"))
            .bold()
            .padding()
            .background(Color("Positive"))
            .foregroundColor(Color.primary)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
//    .frame(maxWidth: 100)
    .clipShape(RoundedRectangle(cornerRadius: 10))
    .disabled(true)
}
struct ModuleViewTest_Previews: PreviewProvider {
    
    static var previews: some View {
//        ModuleViewTest(isFullVersion: .constant(true))
        ModuleViewTest()
    }
}
