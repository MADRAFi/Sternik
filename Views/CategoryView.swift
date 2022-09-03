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
    @ObservedObject var categoryRepository = Category.repository // This ensures we are Observing the Repository!


//    @Binding var isFullVersion: Bool
    @AppStorage("Selected_Questions_Module") private var selectedModule: String = ""
    
    let fullVersionID = Bundle.main.infoDictionary?["FullVersionProduct"] as? String

    /**
     Builds all of the Navigation Links for the Sorted Categories
     */
    @ViewBuilder
    func categoryNavLinks() -> some View {
        let prefix = selectedModule.components(separatedBy: ".")[1]
        ForEach(Array(categoryRepository.sortedCategories)) { item in
            questionNavLink(item: item, prefix: prefix)
        }
    }
    
    /**
     Builds an individual `NavigationLink` for a specific `Category`
     */
    @ViewBuilder
    func questionNavLink(item: Category, prefix: String) -> some View {
        NavigationLink(destination: QuestionView(categories: categoryRepository.sortedCategories.filter({$0.id == item.id }) , title: "Wybrany dział")) {
            HStack {
                Image("Icon_\(prefix)_\(item.id)")
                    .padding(.vertical, 8)
                    .padding(.horizontal, 5)
                Text(item.category_name)
                Spacer()
            }
            
        }
    }
    
    var body: some View {
        
            NavigationView {
                    List {
                        Section {
                            if !store.isFullVersion() {
                                ADBanner()
//                                    .frame(width: 320, height: 50, alignment: .center)
                            }
                            if !selectedModule.isEmpty {
                                categoryNavLinks()
                            }
                            HStack {
                                NavigationLink(destination: QuestionView(categories: Array(categoryRepository.sortedCategories), title: "Wszystkie")) {
                                    HStack {
                                        Image("Icon_Learn")
                                            .padding(.vertical, 8)
                                            .padding(.horizontal, 5)
                                        Text("Wszystkie pytania")
                                        Spacer()
                                    }
                                }
                                
                            }
//                            let favourites = data.categories.values.filter({ category in
//                                return category.questions.contains(where: { $0.isFavourite == true })
//                                
//                            })
                            HStack {
                                NavigationLink(destination: QuestionView(categories: categoryRepository.favourites, title: "Ulubione")) {
                                    HStack {
                                        Image("Icon_Favourite")
                                            .padding(.vertical, 8)
                                            .padding(.horizontal, 5)
                                        Text("Ulubione")
                                        Spacer()
                                    }
                                }
                                .disabled(categoryRepository.favourites.count == 0)
                                
                            }
                            
                            HStack {
                                NavigationLink(destination: QuestionView(categories: categoryRepository.generateQuestionsList(), title: "Egzamin" )) {
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
        static var data = CategoryRepository()
        static var previews: some View {
            CategoryView()
                .environmentObject(Store())
        }
    }
