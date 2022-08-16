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
//        NavigationView {
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

                        ForEach(data.questions) { item in
                            NavigationLink(destination: QuestionView(questions: data.questions.filter({$0.id == item.id }) )) {
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
                        
                    Section {
  
                            HStack {
                                NavigationLink(destination: QuestionView(questions: data.questions)) {
                                    Text("Wszystkie działy")
                                        .padding(5)
                                    Spacer()
                                }
                            }
                            HStack {
                                NavigationLink(destination: QuestionView(questions: data.generateQuestionsList() )) {
                                    Text("Egzamin próbny")
                                        .padding(5)
                                    Spacer()
                                }
                            }

                    }
                    
                }
            }
//        }
    }
}
    struct CategoryView_Previews: PreviewProvider {
        
//        static var questions = categoryList.example_data()
        static var data = QuestionsList()
        
        static var previews: some View {
            CategoryView(data: data)
        }
    }
