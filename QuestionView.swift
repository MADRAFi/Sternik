//
//  ContentView.swift
//  Shared
//
//  Created by MADRAFi on 17/07/2022.
//

import SwiftUI


extension UIColor {
  struct SternikColors {
      static var positive: UIColor  { return UIColor(Color.green) }
      static var negative: UIColor { return UIColor(Color.red) }
      static var clean: UIColor { return UIColor(Color.clear) }
  }
}


struct QuestionView: View {

    @State var questions : [categoryList]
//    @Binding var questions: [categoryList]
    
    @State var isAnswered: Bool = false
    @State var selectedRow : Int = 0
    @State var currentCategory: Int = 0          // index of a category
    @State var currentQuestion: Int = 0          // index of a question
    @State var questionNumber: Int = 1           // current question number in a set
    @State var questionTotal: Int = 1        // number of all questions in set
    
    @AppStorage("Show_Correct_Answer") private var showCorrect : Bool = true

    
    func calculateQuestionsTotal() -> Int {
    // calculates total number of all questions in a set (all categories)
        
        var value: Int = 0
        for item in questions {
            value += item.questions.count
        }
        
        return value
    }
    
    func checkAnswer() {
        switch  questions[currentCategory].questions[currentQuestion].choice {
        case 0:
            isAnswered = false
            selectedRow = 0
        case 1:
            isAnswered = true
            selectedRow = 1
        case 2:
            isAnswered = true
            selectedRow = 2
        case 3:
            isAnswered = true
            selectedRow = 3
        default:
            isAnswered = true
        }
    }
    func ValidateAnswer() -> Bool {
        if  questions[currentCategory].questions[currentQuestion].correct == questions[currentCategory].questions[currentQuestion].choice {
            return true
        } else {
            return false
        }
    }
    func getRowColor(selected: Int, current: Int) -> Color {
        var rowColor: Color = Color(UIColor.SternikColors.clean)
        
        if isAnswered {
            if ValidateAnswer() {

                if selected == current && selected == questions[currentCategory].questions[currentQuestion].choice {
                    rowColor = Color(UIColor.SternikColors.positive)
                } else {
                    rowColor = Color(UIColor.SternikColors.clean)
                }
            } else {
                if current == selected && current == questions[currentCategory].questions[currentQuestion].choice  {
                    rowColor = Color(UIColor.SternikColors.negative)
                } else if showCorrect && current != selected && current == questions[currentCategory].questions[currentQuestion].correct {
                    rowColor = Color(UIColor.SternikColors.positive)
                } else {
                    
                    rowColor = Color(UIColor.SternikColors.clean)
                }
            }

        } else {
            rowColor = Color(UIColor.SternikColors.clean)
        }
        return rowColor
    }
    
    var body: some View {

            List {
// ---------------------------------------------------------------------------
                Section {
                    VStack {
                        HStack {
                            
                            Text(String(questionNumber))
                            Text("/")
                            Text(String(questionTotal))
                            Spacer()
                            Text(String(questions[currentCategory].id) + ":")
                            Text(questions[currentCategory].category_name)
                        }

                        ProgressView(value: Float(questionNumber) / Float(questionTotal))

                    }
                }
                .onAppear {
                    questionTotal = self.calculateQuestionsTotal()
                }
                
// ---------------------------------------------------------------------------
                Section(header: Text("Pytanie")) {
                    VStack {
                        HStack {
                            Text(String(questions[currentCategory].questions[currentQuestion].question_id))
                            Text(questions[currentCategory].questions[currentQuestion].question)
                                .padding(10)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                
// ---------------------------------------------------------------------------
                Section(header: Text("Odpowiedzi")) {
                    HStack {
                        Text("A")
                            .padding()
                        if (questions[currentCategory].questions[currentQuestion].images) {
                            Image("q\(questions[currentCategory].questions[currentQuestion].question_id)_a1")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 128, height: 128)
                        } else {
                            Text(questions[currentCategory].questions[currentQuestion].answer_1)
                                .padding(7)
                        }
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedRow = 1
                        questions[currentCategory].questions[currentQuestion].choice = 1
                        isAnswered = true
                    }
                    .foregroundColor(.primary)
                    .background(getRowColor(selected: selectedRow, current: 1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .disabled(self.isAnswered)
                    
                    
                    HStack() {
                        Text("B")
                            .padding()
                        if (questions[currentCategory].questions[currentQuestion].images) {
                            Image("q\(questions[currentCategory].questions[currentQuestion].question_id)_a2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 128, height: 128)
                        } else {
                            Text(questions[currentCategory].questions[currentQuestion].answer_2)
                                .padding(7)

                        }
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedRow = 2
                        questions[currentCategory].questions[currentQuestion].choice = 2
                        isAnswered = true
                    }
                    .foregroundColor(.primary)
                    .background(getRowColor(selected: selectedRow, current: 2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .disabled(self.isAnswered)
                    
                    HStack {
                        Text("C")
                            .padding()
                        if (questions[currentCategory].questions[currentQuestion].images) {
                            Image("q\(questions[currentCategory].questions[currentQuestion].question_id)_a3")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 128, height: 128)
                        } else {
                            Text(questions[currentCategory].questions[currentQuestion].answer_3)
                                .padding(7)

                            
                        }
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedRow = 3
                        questions[currentCategory].questions[currentQuestion].choice = 3
                        isAnswered = true
                    }
                    .foregroundColor(.primary)
                    .background(getRowColor(selected: selectedRow, current: 3))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .disabled(self.isAnswered)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Nauka")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if (currentQuestion > 0) {
                            currentQuestion -= 1
                        } else {
                            if (currentCategory > 0) {
                                currentCategory -= 1
                                currentQuestion = questions[currentCategory].questions.count - 1
                            }
                        }
                        if questionNumber > 1 {
                            questionNumber -= 1
                        }
                        checkAnswer()
                        
                    },
                           label: {
                        Image(systemName: "arrow.left.square.fill")
                            .imageScale(.large)
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if currentQuestion < questions[currentCategory].questions.count - 1 {
                            currentQuestion += 1
                        } else {
                            if (currentCategory < questions.count - 1) {
                                currentCategory += 1
                                currentQuestion = 0
                            }
                        }
                        if questionNumber < questionTotal {
                            questionNumber += 1
                        }
                        checkAnswer()
                    },
                           label: {
                        Image(systemName: "arrow.right.square.fill")
                            .imageScale(.large)
                    })
                }
            }
            
        
    }
}


struct QuestionView_Previews: PreviewProvider {
    
    static var questions = categoryList.example_data()
    
    static var previews: some View {
        QuestionView(questions: questions)
    }
}