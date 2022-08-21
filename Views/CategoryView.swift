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
    @ObservedObject var data : QuestionsList
    @Binding var isFullVersion: Bool

    var body: some View {
        
            NavigationView {
                    List {
                        Section {
                            if !isFullVersion {
                                ADBanner()
//                                        .frame(width: 320, height: 100, alignment: .center)
                            }
                            ForEach(data.questions) { item in
                                NavigationLink(destination: QuestionView(questions: data.questions.filter({$0.id == item.id }) , title: "Wybrany dział")) {
                                    HStack {
                                        Image("Icon_\(item.id)")
                                            .padding(.vertical, 8)
                                            .padding(.horizontal)
                                        Text(item.category_name)
                                        Spacer()
                                    }
                                    
                                }
                            }
                            
                            HStack {
                                NavigationLink(destination: QuestionView(questions: data.questions, title: "Nauka")) {
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
                                NavigationLink(destination: QuestionView(questions: data.generateQuestionsList(), title: "Egzamin" )) {
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
                    }
                    .navigationTitle("Kategorie")
                    .navigationBarTitleDisplayMode(.large)

            }
            .navigationViewStyle(.stack)
        
    }
}
    struct CategoryView_Previews: PreviewProvider {
        
//        static var questions = categoryList.example_data()
        static var data = QuestionsList()
        
        static var previews: some View {
            CategoryView(data: data, isFullVersion: .constant(true))
        }
    }
