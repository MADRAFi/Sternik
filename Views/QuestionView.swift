//
//  ContentView.swift
//  Shared
//
//  Created by MADRAFi on 17/07/2022.
//

import SwiftUI

struct QuestionView: View {

    @Environment(\.presentationMode) var presentationMode
    @State var categories : [Category]

    @State var isAnswered: Bool = false
    @State var showStats: Bool = false
    @State var selectedRow : Int = 0
    @State var lastCategory: Int = 0             // index of previous category before jump
    @State var lastQuestion: Int = 0            // index of previous question before jump
    @State var lastQuestionNumber: Int = 1       // last question number in a set
    @State var currentCategory: Int = 0          // index of a category
    @State var currentQuestion: Int = 0          // index of a question
    @State var questionNumber: Int = 1           // current question number in a set
    var questionTotal: Int {
    // calculates total number of all questions in a set (all categories)
        
        var value: Int = 0
        for item in categories {
            value += item.questions.count
        }
        
        return value
    }
    @State var answersCorrect: Int = 0
    @State var answersWrong: Int = 0
    @State var startTime: Date = .now
    @State var endTime: Date = .now
    @State var showFavourite: Bool = false
    
    @AppStorage("Show_Correct_Answer") private var showCorrect : Bool = true
    @AppStorage("Show_Next_Question") private var ShowNextQuestion : Bool = true
    @AppStorage("Selected_Questions_Module") private var selectedModule: String = ""
    
    let builtInProduct = Bundle.main.infoDictionary?["BuiltInProduct"] as? String
    let chosenCategory: CategoryType
    
//    @GestureState var scale = 1.0
//    var magnification: some Gesture {
//        MagnificationGesture()
//            .updating($scale) { currentState, pastState, transaction in
//                pastState = currentState
//            }
//    }
    
    var title: String {
        switch chosenCategory {
        case .id:
            return "Wybrany dział"
        case .favourites:
            return "Ulubione"
        case .all:
            return "Wszytkie"
        case .exam:
            return "Egzamin"
        }
    }
    
    func checkAnswer() {
        switch  categories[currentCategory].questions[currentQuestion].choice {
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
    
    /**
     Returns `true` if the current Answer is Correct, `false` if it is not
     */
    func validateAnswer() -> Bool {
        return categories[currentCategory].questions[currentQuestion].correct == categories[currentCategory].questions[currentQuestion].choice
    }
    
    func getRowColor(selected: Int, current: Int) -> Color {
        var rowColor: Color = Color.clear
        
        if isAnswered {
            if validateAnswer() {
                if selected == current && selected == categories[currentCategory].questions[currentQuestion].choice {
                    rowColor = Color("Positive")
                } else {
                    rowColor = Color.clear
                }
            } else {
                if current == selected && current == categories[currentCategory].questions[currentQuestion].choice  {
                    rowColor = Color("Negative")
                } else if showCorrect && current != selected && current == categories[currentCategory].questions[currentQuestion].correct {
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
                currentQuestion = categories[currentCategory].questions.count - 1
            }
        }
        if questionNumber > 1 {
            questionNumber -= 1
        }
        checkAnswer()
    }
    
    fileprivate func nextQuestion() {
        if currentQuestion < categories[currentCategory].questions.count - 1 {
            currentQuestion += 1
        } else {
            if (currentCategory < categories.count - 1) {
                currentCategory += 1
                currentQuestion = 0
            }
        }
        if questionNumber < questionTotal {
            questionNumber += 1
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
    
    fileprivate func checkFinished() {
        // show stats view
        if questionTotal == answersCorrect + answersWrong {
            endTime = .now
            showStats = true
        }
    }

//    var allQuestions = Category[thisCategory.id]?.questions
//    let questionIndex = allQuestions?.firstIndex(where: {$0.id == thisQuestion.id })
//
    
//    allQuestions?[questionIndex!] = thisQuestion
//    thisCategory.questions = allQuestions ?? []
//    Category[thisCategory.id] = thisCategory
//
    func removeFavourites() {
        var categoryIndex = 0 /// We always start at Index 0 of the Category Array
        for category in categories { /// Iterate Categories
            var updatedCategory = category /// Take a copy of the Category we're about to update
            var allQuestions = Category[category.id]?.questions
            var questionIndex = 0 /// We always start at Index 0 of the Question Array
            
            for question in category.questions { /// Iterate Questions in Category
                var updatedQuestion = question /// Take a copy of the Question we're about to update
                let allQuestionIndex = allQuestions?.firstIndex(where: {$0.id == question.id })
                
                updatedQuestion.isFavourite = false /// Set `isFavorite` to `false`

//                updatedCategory.questions[questionIndex] = updatedQuestion /// Update this Question in the Category
                allQuestions?[allQuestionIndex!] = updatedQuestion
                
                categories[categoryIndex].questions[questionIndex] = updatedQuestion /// Update this Question in view collecion of categories
                questionIndex += 1 /// Increment the Question Index for the next iteration
            }
            updatedCategory.questions = allQuestions ?? []
            Category[category.id] = updatedCategory
            categoryIndex += 1
        }
    }
    
    /**
     Builds just the Header Section of the View
     */
    @ViewBuilder
    func headerSection() -> some View {
        Section {
            VStack {
                HStack() {
                    Text(String(categories[currentCategory].id) + ":")
                    Text(categories[currentCategory].category_name)
                    Spacer()
                }
                ProgressView(value: Float(questionNumber) / Float(questionTotal))
//                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                HStack {
                    //                        Text(startTime, style: .relative)
                    if !selectedModule.isEmpty {
                        let module_name = selectedModule.components(separatedBy: ".")[1].uppercased()
                        Text(module_name)
                            .bold()
                    }
                    Spacer()
                    Text(String(questionNumber))
                    Text("/")
                    Text(String(questionTotal))
                }
            }
            .padding(.top)
        }
        .padding(.horizontal)
    }
    
    /**
     Builds the Question Section of your View
     */
    @ViewBuilder
    func questionSection() -> some View {
        Section(header: Text("Pytanie")) {
            VStack(alignment: .center) {
                HStack {
                    Text(String(categories[currentCategory].questions[currentQuestion].question_id))
                    Text(categories[currentCategory].questions[currentQuestion].question)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(5)
                }
                if !(categories[currentCategory].questions[currentQuestion].question_image.isEmpty) {
                    Image((categories[currentCategory].questions[currentQuestion].question_image))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
//                        .scaleEffect(scale)
//                        .gesture(magnification)
//                        .scaledToFit()
                    //                        .frame(maxWidth: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .padding(5)
//                        .onHover(perform: {
//
//                        })

                }

            }
        }
    }
    
    /**
     Builds only the Answer Section of your View
     */
    @ViewBuilder
    func answerSection() -> some View {
        Section(header: Text("Odpowiedzi")) {
            HStack {
                Text("A")
                    .padding(.horizontal, 5)
//                    .padding(.trailing, 5)
                if (categories[currentCategory].questions[currentQuestion].images) {
                    Image("q\(categories[currentCategory].questions[currentQuestion].question_id)_a1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 128, height: 128)
                } else {
                    Text(categories[currentCategory].questions[currentQuestion].answer_1)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.vertical, 5)
                }
                Spacer()
            }
            .padding(.vertical ,2)
            .lineLimit(nil)
            .contentShape(Rectangle())
            .onTapGesture {
                selectedRow = 1
                categories[currentCategory].questions[currentQuestion].choice = 1
                isAnswered = true
                incrementAnswerCounters()
                checkFinished()
                advanceToNextQuestion()
            }
            .foregroundColor(.primary)
            .background(getRowColor(selected: selectedRow, current: 1))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .disabled(self.isAnswered)
            
            
            HStack() {
                Text("B")
                    .padding(.horizontal, 5)
//                    .padding(.trailing, 5)
                if (categories[currentCategory].questions[currentQuestion].images) {
                    Image("q\(categories[currentCategory].questions[currentQuestion].question_id)_a2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 128, height: 128)
                } else {
                    Text(categories[currentCategory].questions[currentQuestion].answer_2)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.vertical, 5)
                    
                }
                Spacer()
            }
            .padding(.vertical ,2)
            .lineLimit(nil)
            .contentShape(Rectangle())
            .onTapGesture {
                selectedRow = 2
                categories[currentCategory].questions[currentQuestion].choice = 2
                isAnswered = true
                incrementAnswerCounters()
                checkFinished()
                advanceToNextQuestion()
            }
            .foregroundColor(.primary)
            .background(getRowColor(selected: selectedRow, current: 2))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .disabled(self.isAnswered)
            
            HStack {
                Text("C")
                    .padding(.horizontal, 5)
//                    .padding(.trailing, 5)
                if (categories[currentCategory].questions[currentQuestion].images) {
                    Image("q\(categories[currentCategory].questions[currentQuestion].question_id)_a3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 128, height: 128)
                } else {
                    Text(categories[currentCategory].questions[currentQuestion].answer_3)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.vertical, 5)
                    
                    
                }
                Spacer()
            }
            .padding(.vertical ,2)
            .lineLimit(nil)
            .contentShape(Rectangle())
            .onTapGesture {
                selectedRow = 3
                categories[currentCategory].questions[currentQuestion].choice = 3
                isAnswered = true
                incrementAnswerCounters()
                checkFinished()
                advanceToNextQuestion()
            }
            .foregroundColor(.primary)
            .background(getRowColor(selected: selectedRow, current: 3))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .disabled(self.isAnswered)
        }
        //.multilineTextAlignment(.leading)
        .lineLimit(nil)
    }
        
    var body: some View {
        VStack {
            headerSection()
            List {
                questionSection()
                
                answerSection()
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            //            .listStyle(GroupedListStyle())
            .onAppear {
//                questionTotal = self.calculateQuestionsTotal()
                if questionTotal == answersCorrect + answersWrong && showStats == true {
                    showStats = false
                } else {
                    startTime = .now
                }
                if selectedModule.isEmpty {
                    selectedModule = builtInProduct!
                }
            }
            .onDisappear() {
                presentationMode.wrappedValue.dismiss()
            }
            .sheet(isPresented: $showStats) {
                StatsView(showStats: $showStats, startTime: $startTime, endTime: $endTime, questionTotal: questionTotal, answersCorrect: $answersCorrect, answersWrong: $answersWrong)
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    },
                           label: {
                        Image(systemName: "chevron.backward")
                            .font(Font.system(.title).bold())

                    })
                }
                ToolbarItemGroup(placement: .status) {

                    Button(action: {
                        lastCategory = currentCategory
                        lastQuestion = currentQuestion
                        lastQuestionNumber = questionNumber
                        currentQuestion = 0
                        currentCategory = 0
                        questionNumber = 1
                    },
                           label: {
                        Image("arrow.backward.to.line.square.fill")
                            .font(Font.system(.title))
                    })
                    

                    Button(action: {
                        lastCategory = currentCategory
                        lastQuestion = currentQuestion
                        lastQuestionNumber = questionNumber
                        currentCategory = categories.count - 1
                        currentQuestion = categories[currentCategory].questions.count - 1
                        questionNumber = questionTotal
                        
                    },
                           label: {
                        Image("arrow.forward.to.line.square.fill")
                            .font(Font.system(.title))
                    })
                    Button(action: {
                        currentCategory = lastCategory
                        currentQuestion = lastQuestion
                        questionNumber = lastQuestionNumber
                        checkAnswer()
                    },
                           label: {
                        Image(systemName: "pin.square.fill")
                            .font(Font.system(.title))
                    })
                    Button(action: {
                        previousQuestion()
                    },
                           label: {
                        Image(systemName: "arrow.left.square.fill")
                            .font(Font.system(.title))
                    })
                    Button(action: {
                        nextQuestion()
                    },
                           label: {
                        Image(systemName: "arrow.right.square.fill")
                            .font(Font.system(.title))
                    })
                }

                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        var thisCategory = categories[currentCategory]
                        var thisQuestion = thisCategory.questions[currentQuestion]
                        var allQuestions = Category[thisCategory.id]?.questions
                        let questionIndex = allQuestions?.firstIndex(where: {$0.id == thisQuestion.id })
                        
                        thisQuestion.isFavourite.toggle()
//                        thisCategory.questions[currentQuestion] = thisQuestion
                        allQuestions?[questionIndex!] = thisQuestion
                        thisCategory.questions = allQuestions ?? []
                        Category[thisCategory.id] = thisCategory

                        categories[currentCategory].questions[currentQuestion] = thisQuestion
                    },
                           label: {
                        if categories[currentCategory].questions[currentQuestion].isFavourite {
                            Image(systemName: "bookmark.square.fill")
                                .font(Font.system(.title))
                                .foregroundColor(.red)
                        } else {
                            Image(systemName: "bookmark.square")
                                .font(Font.system(.title))
                        }
                        
                    })
                    Button(action: {
                        removeFavourites()
                    },
                           label: {
                        Image("bookmark.square.crossed.fill")
                            .font(Font.system(.title))
                    })
     
                }
                
            }
        }
    }
}


struct QuestionView_Previews: PreviewProvider {
    
    static var categories = Category.example_data()
    
    static var previews: some View {
        QuestionView(categories: categories, chosenCategory: .all)
    }
}
