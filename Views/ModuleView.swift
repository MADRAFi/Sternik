//
//  ModuleView.swift
//  Sternik
//
//  Created by MADRAFi on 20/08/2022.
//

import SwiftUI

struct ModuleView: View {
    var body: some View {
        
        NavigationView {
                List {
                    Section {

                        
                        HStack {
                            NavigationLink(destination: Text("Purachse 1")) {
                                HStack {
                                    Image("Icon_Learn")
                                        .padding(.vertical, 8)
                                        .padding(.horizontal)
                                    Text("Nauka")
                                    Spacer()
                                }
                            }
                            
                        }
                        
                        HStack {
                            NavigationLink(destination: Text("Purchase 2")) {
                                HStack {
                                    Image("Icon_Exam")
                                        .padding(.vertical, 8)
                                        .padding(.horizontal)
                                    Text("Egzamin próbny")
                                    Spacer()
                                }
                                
                            }
                            
                        }
                        
                    }
//                    ADBanner()
//                            .frame(width: 320, height: 100, alignment: .center)
                }
                .navigationTitle("Moduły")
                .navigationBarTitleDisplayMode(.large)

        }
        .navigationViewStyle(.stack)
        
        
        
        
        
    }
}

struct ModuleView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleView()
    }
}
