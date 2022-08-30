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
    @EnvironmentObject var data : QuestionsList

    @AppStorage("Selected_Questions_Module") private var selectedModule: String = ""
    
    let fullVersionID = Bundle.main.infoDictionary?["FullVersionProduct"] as? String

    var body: some View {
        
            NavigationView {
                    List {
                        Section {
                            if !(store.purchasedProducts.contains(where: {$0.id == fullVersionID})) {
                                ADBanner()
//                                    .frame(width: 320, height: 50, alignment: .center)
                            }
                            if !selectedModule.isEmpty {
                                let prefix = selectedModule.components(separatedBy: ".")[1]
                                ForEach(data.questions) { item in
                                    NavigationLink(destination: QuestionView(category: .chosenCategory(item.id), questions: $data.questions.filter({$0.id == item.id }))) {
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
                                NavigationLink(destination: QuestionView(category: .all, questions: $data.questions)) {
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
                                NavigationLink(destination: QuestionView(category: .favourites, questions: data.questions.filter({ category in
                                    return category.questions.contains(where: { $0.isFavourite == true })
                                }))) {
                                    HStack {
                                        Image("Icon_Learn")
                                            .padding(.vertical, 8)
                                            .padding(.horizontal, 5)
                                        Text("Ulubione")
                                        Spacer()
                                    }
                                }
                                
                            }
                            
                            HStack {

                                NavigationLink(destination: QuestionView(category: .exam, questions: $data.generateQuestionsList)) {
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
                data.load(module: selectedModule)
            }
        
    }
}
    struct CategoryView_Previews: PreviewProvider {
        
        static var previews: some View {
            CategoryView()
        }
    }
