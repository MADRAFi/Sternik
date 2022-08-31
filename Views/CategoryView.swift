//
//  SwiftUIView.swift
//  Sternik
//
//  Created by MADRAFi on 08/08/2022.
//

import SwiftUI
import StoreKit

struct CategoryView: View {    
    @EnvironmentObject var store: Store
    
    @ObservedObject var data = Category.repository // This ensures we are Observing the Repository!

//    @Binding var isFullVersion: Bool
    @AppStorage("Selected_Questions_Module") private var selectedModule: String = ""
    
    let fullVersionID = Bundle.main.infoDictionary?["FullVersionProduct"] as? String

    var body: some View {
        
            NavigationView {
                    List {
                        Section {
//                            if !isFullVersion {
                            if !(store.purchasedProducts.contains(where: {$0.id == fullVersionID})) {
                                ADBanner()
//                                    .frame(width: 320, height: 50, alignment: .center)
                            }
                            if !selectedModule.isEmpty {
                                let prefix = selectedModule.components(separatedBy: ".")[1]
                                ForEach(Array(data.categories.values)) { item in
                                    NavigationLink(destination: QuestionView(categories: data.categories.values.filter({$0.id == item.id }) , title: "Wybrany dział")) {
                                        HStack {
                                            Image("Icon_\(prefix)_\(item.id)")
                                                .padding(.vertical, 8)
                                                .padding(.horizontal, 5)
                                            Text(item.category_name)
                                            Spacer()
                                        }
                                        
                                    }
                                }
                            }
                            HStack {
                                NavigationLink(destination: QuestionView(categories: Array(data.categories.values), title: "Wszystkie")) {
                                    HStack {
                                        Image("Icon_Learn")
                                            .padding(.vertical, 8)
                                            .padding(.horizontal, 5)
                                        Text("Wszystkie pytania")
                                        Spacer()
                                    }
                                }
                                
                            }
                            
                            HStack {
                                NavigationLink(destination: QuestionView(categories: data.generateQuestionsList(), title: "Egzamin" )) {
                                    HStack {
                                        Image("Icon_Exam")
                                            .padding(.vertical, 8)
                                            .padding(.horizontal, 5)
                                        Text("Egzamin próbny")
                                        Spacer()
                                    }
                                    
                                }
                                
                            }
                            
                        }
                    }
                    .navigationTitle("Kategorie")
                    .navigationBarTitleDisplayMode(.large)

            }
            .navigationViewStyle(.stack)
            .onAppear() {
                if selectedModule.isEmpty {
                    selectedModule = selectedModule
                }
            }
        
    }
}
    struct CategoryView_Previews: PreviewProvider {
        
//        static var questions = categoryList.example_data()
        static var data = CategoryRepository()
        
        static var previews: some View {
//            CategoryView(isFullVersion: .constant(true))
            CategoryView()
                .environmentObject(Store())
        }
    }
