//
//  ContentView.swift
//  Shared
//
//  Created by MADRAFi on 17/07/2022.
//

import SwiftUI

struct QuestionView: View {

    @State var questions : [categoryList]
    @State var title: String

    @State var isAnswered: Bool = false
    @State var showStats: Bool = false
    @State var selectedRow : Int = 0
    @State var currentCategory: Int = 0          // index of a category
    @State var currentQuestion: Int = 0          // index of a question
    @State var questionNumber: Int = 1           // current question number in a set
    @State var questionTotal: Int = 1        // number of all questions in set
    @State var answersCorrect: Int = 0
    @State var answersWrong: Int = 0
    @State var startTime: Date = .now
    @State var endTime: Date = .now
    
    
    @AppStorage("Show_Correct_Answer") private var showCorrect : Bool = true
    @AppStorage("Show_Next_Question") private var ShowNextQuestion : Bool = false
      
    
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
    func validateAnswer() -> Bool {
        if  questions[currentCategory].questions[currentQuestion].correct == questions[currentCategory].questions[currentQuestion].choice {
            return true
        } else {
            return false
        }
    }
    func getRowColor(selected: Int, current: Int) -> Color {
        var rowColor: Color = Color.clear
        
        if isAnswered {
            if validateAnswer() {
                if selected == current && selected == questions[currentCategory].questions[currentQuestion].choice {
                    rowColor = Color("Positive")
                } else {
                    rowColor = Color.clear
                }
            } else {
                if current == selected && current == questions[currentCategory].questions[currentQuestion].choice  {
                    rowColor = Color("Negative")
                } else if showCorrect && current != selected && current == questions[currentCategory].questions[currentQuestion].correct {
                    rowColor = Color("Positive")
                } else {
                    
                    rowColor = Color.clear
                }
            }

        } else {
            rowColor = Color.clear
        }
        return rowColor
    }
    
    func advanceToNextQuestion() {
        if ShowNextQuestion && isAnswered {

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // code to execute after 1 second
                nextQuestion()
            }
        }
    }
    
    fileprivate func previousQuestion() {
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
    }
    
    fileprivate func nextQuestion() {
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
        } else {
            // show stats
            if questionTotal == answersCorrect + answersWrong {
                showStats = true
            } else {
                endTime = .now
            }
        }
        checkAnswer()
    }
    
    fileprivate func incrementAnswerCounters() {
        if validateAnswer() {
            answersCorrect += 1
        } else {
            answersWrong += 1
        }
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
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            .controlSize(/*@START_MENU_TOKEN@*/.large/*@END_MENU_TOKEN@*/)
//                        Text(startTime, style: .relative)

                        
                    }
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
//                .listStyle(GroupedListStyle())
                
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
                                .lineLimit(nil)
                                .padding()
                        }
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedRow = 1
                        questions[currentCategory].questions[currentQuestion].choice = 1
                        isAnswered = true
                        incrementAnswerCounters()
                        advanceToNextQuestion()
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
                                .lineLimit(nil)
                                .padding()

                        }
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedRow = 2
                        questions[currentCategory].questions[currentQuestion].choice = 2
                        isAnswered = true
                        incrementAnswerCounters()
                        advanceToNextQuestion()
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
                                .lineLimit(nil)
                                .padding()

                            
                        }
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedRow = 3
                        questions[currentCategory].questions[currentQuestion].choice = 3
                        isAnswered = true
                        incrementAnswerCounters()
                        advanceToNextQuestion()
                    }
                    .foregroundColor(.primary)
                    .background(getRowColor(selected: selectedRow, current: 3))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .disabled(self.isAnswered)
                }
//                .multilineTextAlignment(.leading)
                .lineLimit(nil)
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.large)
//            .listStyle(GroupedListStyle())
            .onAppear {
                questionTotal = self.calculateQuestionsTotal()
                if questionTotal == answersCorrect + answersWrong && showStats == true {
                    showStats = false
//                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    startTime = .now
                }
            }
            .sheet(isPresented: $showStats) {
                StatsView(showStats: $showStats, startTime: $startTime, endTime: $endTime, questionTotal: $questionTotal, answersCorrect: $answersCorrect, answersWrong: $answersWrong)
            }

            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        currentQuestion = 0
                        currentCategory = 0
                        questionNumber = 1
                    },
                        label: {
                            Image(systemName: "1.square.fill")
                                .imageScale(.large)
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        previousQuestion()
                    },
                        label: {
                            Image(systemName: "arrow.left.square.fill")
                                .imageScale(.large)
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        nextQuestion()
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
        QuestionView(questions: questions, title: "Preview")
    }
}
