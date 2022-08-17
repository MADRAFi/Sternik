//
//  SwiftUIView.swift
//  Sternik
//
//  Created by MADRAFi on 08/08/2022.
//

import SwiftUI

struct CategoryView: View {
    
    @ObservedObject var data : QuestionsList
    
    var body: some View {
        
            NavigationView {
                    List {
                        Section {
                            ForEach(data.questions) { item in
                                NavigationLink(destination: QuestionView(questions: data.questions.filter({$0.id == item.id }) , title: "Wybrany dział")) {
                                    HStack {
                                        Image("Icon_\(item.id)")
                                            .padding()
                                        Text(item.category_name)
                                        Spacer()
                                    }
                                    
                                }
                            }
                            
                            HStack {
                                NavigationLink(destination: QuestionView(questions: data.questions, title: "Wszystkie kategorie")) {
                                    HStack {
                                        Image("Icon_Learn")
                                            .padding()
                                        Text("Wszystkie kategorie")
                                        Spacer()
                                    }
                                }
                                
                            }
                            
                            HStack {
                                NavigationLink(destination: QuestionView(questions: data.generateQuestionsList(), title: "Egzamin" )) {
                                    HStack {
                                        Image("Icon_Exam")
                                            .padding()
                                        Text("Egzamin próbny")
                                        Spacer()
                                    }
                                    
                                }
                                
                            }
                            
                        }
                    }
                    .navigationTitle("Wybór kategorii")
                    .navigationBarTitleDisplayMode(.large)

            }
            .navigationViewStyle(.stack)

        
    }
}
    struct CategoryView_Previews: PreviewProvider {
        
//        static var questions = categoryList.example_data()
        static var data = QuestionsList()
        
        static var previews: some View {
            CategoryView(data: data)
        }
    }
