//
//  SwiftUIView.swift
//  Sternik
//
//  Created by MADRAFi on 08/08/2022.
//

import SwiftUI

struct CategoryView: View {
    
    @State var questions : [categoryList]
    
    var body: some View {
        NavigationView {
            List {
                // ---------------------------------------------------------------------------
                Section {
                    VStack {
                        HStack {
                            Text("Wybór testu")
                            //                            Spacer()
                        }
                    }
                }
                // ---------------------------------------------------------------------------
                Section {
                    VStack {
                        ForEach(questions) { item in
                            NavigationLink(destination: QuestionView(questions: questions.filter {$0.id == item.id } )) {
                                HStack {
                                    Text(String(item.id))
                                        .padding()
                                    Text(item.category_name)
                                    Spacer()
                                }
                                //                            }
                                //                            .navigationBarBackButtonHidden(true)
                            }
                        }
                        
                    }
                    Section {
                        VStack {
                            HStack {
                                NavigationLink(destination: QuestionView(questions: questions )) {
                                    Text("Wszystkie działy")
                                        .padding()
                                    Spacer()
                                }
                            }
                            HStack {
                                NavigationLink(destination: QuestionView(questions: questions )) {
                                    Text("Egzamin próbny")
                                        .padding()
                                    Spacer()
                                }
                            }
                        }
                    }
                    
                }
            }
        }
    }
}
    struct CategoryView_Previews: PreviewProvider {
        
        static var questions = categoryList.example_data()
        
        static var previews: some View {
            CategoryView(questions: questions)
        }
    }
