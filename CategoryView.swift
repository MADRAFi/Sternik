//
//  SwiftUIView.swift
//  Sternik
//
//  Created by MADRAFi on 08/08/2022.
//

import SwiftUI

struct CategoryView: View {
    
    //    @State var questions : [categoryList]
    @ObservedObject var data : QuestionsList
    
    var body: some View {
        NavigationView {

                //            Image("Background")
                //                .resizable()
                //                .scaledToFill()
                //                .ignoresSafeArea()
                ////                .opacity(0.5)
                
                List {
                    Section {
                        
                        ForEach(data.questions) { item in
                            NavigationLink(destination: QuestionView(questions: data.questions.filter({$0.id == item.id }) , title: "Wybrany dział")) {
                                HStack {
                                    Text(String(item.id))
                                        .padding()
                                    Text(item.category_name)
                                    Spacer()
                                }
                                
                            }
                        }
                        
                        //                    Section {
                        
                        HStack {
                            NavigationLink(destination: QuestionView(questions: data.questions, title: "Wszystkie kategorie")) {
                                Text("Wszystkie kategorie")
                                    .padding(5)
                                Spacer()
                            }
                            
                        }
                        HStack {
                            NavigationLink(destination: QuestionView(questions: data.generateQuestionsList(), title: "Egzamin" )) {
                                Text("Egzamin próbny")
                                    .padding(5)
                                Spacer()
                            }
                            
                        }
                        
                        //                    }
                        
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
