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
struct ContentView: View {
    @ObservedObject var data = DataLoader()
    
    var calc: Float = 1 / 10
    @State public var Answer_A: Bool = false
    @State public var Answer_B: Bool = false
    @State public var Answer_C: Bool = false
    @State public var isAnswered: Bool = false
    @State public var selectedRow : Int = 0
    
    func checkAnswer() {
        switch  data.questionsData[data.currentCategory].questions[data.currentQuestion].choice {
        case 0:
            isAnswered = false
            selectedRow = 0
        case 1:
            isAnswered = true
            Answer_A = true
            Answer_B = false
            Answer_C = false
            selectedRow = 1
        case 2:
            isAnswered = true
            Answer_A = false
            Answer_B = true
            Answer_C = false
            selectedRow = 2
        case 3:
            isAnswered = true
            Answer_A = false
            Answer_B = false
            Answer_C = true
            selectedRow = 3
        default:
            isAnswered = true
        }
    }
    
    func getRowColor(selected: Int, current: Int) -> Color {
        var rowColor: Color = Color(UIColor.SternikColors.clean)
//        return answer && isAnswered ? Color(Color.yellow as! CGColor) : Color(Color.clear as! CGColor)
        if isAnswered {
            if data.ValidateAnswer() {
                if selected == current && selected == data.questionsData[data.currentCategory].questions[data.currentQuestion].choice {
                    rowColor = Color(UIColor.SternikColors.positive)
                } else {
                    rowColor = Color(UIColor.SternikColors.clean)
                }
            } else {
                if current == selected && current == data.questionsData[data.currentCategory].questions[data.currentQuestion].choice  {
                    rowColor = Color(UIColor.SternikColors.negative)
                } else if current != selected && current == data.questionsData[data.currentCategory].questions[data.currentQuestion].correct {
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
        NavigationView {
            List {
// ---------------------------------------------------------------------------
                Section {
                    VStack {
                        HStack {
                            Text(String(data.questionsData[data.currentCategory].questions[data.currentQuestion].question_id))
                            Spacer()
                            Text(String(data.questionsData[data.currentCategory].id) + ":")
                            Text(data.questionsData[data.currentCategory].category)
                        }

                        ProgressView(value: Float(data.currentQuestion + 1) / Float(data.questionsData[data.currentCategory].questions.count ))

                    }
                }
                
// ---------------------------------------------------------------------------
                Section {
                    VStack {
                        Text(data.questionsData[data.currentCategory].questions[data.currentQuestion].question)
                            .padding(10)
                        
                        
                    }
                }
                
// ---------------------------------------------------------------------------
                Section {
                    HStack {
                        Text("A")
                            .padding()
                        if (data.questionsData[data.currentCategory].questions[data.currentQuestion].images) {
                            Image("q\(data.questionsData[data.currentCategory].questions[data.currentQuestion].question_id)_a1")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 128, height: 128)
                        } else {
                            Text(data.questionsData[data.currentCategory].questions[data.currentQuestion].answer_1)
                        }
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        Answer_A = true
                        Answer_B = false
                        Answer_C = false
                        selectedRow = 1
                        data.questionsData[data.currentCategory].questions[data.currentQuestion].choice = 1
                        isAnswered = true
                    }
                    .foregroundColor(.primary)
//                    .background(getRowColor(answer: Answer_A))
                    .background(getRowColor(selected: selectedRow, current: 1))
                    .disabled(self.isAnswered)
                    
                    
                    HStack() {
                        Text("B")
                            .padding()
                        if (data.questionsData[data.currentCategory].questions[data.currentQuestion].images) {
                            Image("q\(data.questionsData[data.currentCategory].questions[data.currentQuestion].question_id)_a2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 128, height: 128)
                        } else {
                            Text(data.questionsData[data.currentCategory].questions[data.currentQuestion].answer_2)

                        }
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        Answer_A = false
                        Answer_B = true
                        Answer_C = false
                        selectedRow = 2
                        data.questionsData[data.currentCategory].questions[data.currentQuestion].choice = 2
                        isAnswered = true
                    }
                    .foregroundColor(.primary)
//                    .background(getRowColor(answer: Answer_B))
                    .background(getRowColor(selected: selectedRow, current: 2))
                    .disabled(self.isAnswered)
                    
                    HStack {
                        Text("C")
                            .padding()
                        if (data.questionsData[data.currentCategory].questions[data.currentQuestion].images) {
                            Image("q\(data.questionsData[data.currentCategory].questions[data.currentQuestion].question_id)_a3")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 128, height: 128)
                        } else {
                            Text(data.questionsData[data.currentCategory].questions[    data.currentQuestion].answer_3)

                            
                        }
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        Answer_A = false
                        Answer_B = false
                        Answer_C = true
                        selectedRow = 3
                        data.questionsData[data.currentCategory].questions[data.currentQuestion].choice = 3
                        isAnswered = true
                    }
                    .foregroundColor(.primary)
//                    .background(getRowColor(answer: Answer_C))
                    .background(getRowColor(selected: selectedRow, current: 3))
                    .disabled(self.isAnswered)
                }
            }
            .navigationTitle("Nauka")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if (data.currentQuestion > 0) {
                            data.currentQuestion -= 1
                        } else {
                            if (data.currentCategory > 0) {
                                data.currentCategory -= 1
                                data.currentQuestion = data.questionsData[data.currentCategory].questions.count - 1
                            }
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
                        if data.currentQuestion < data.questionsData[data.currentCategory].questions.count - 1 {
                            data.currentQuestion += 1
                        } else {
                            if (data.currentCategory < data.questionsData.count - 1) {
                                data.currentCategory += 1
                                data.currentQuestion = 0
                            }
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
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//struct SelectedButtonStyle: ButtonStyle {
//    func makeBody(configuration: Self.Configuration) -> some View {
//        configuration.label
////            .foregroundColor(Color.white)
//            .padding()
//            .frame(width: 100, height: 100)
//            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
//            .cornerRadius(15.0)
//
//    }
//}

