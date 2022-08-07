//
//  ContentView.swift
//  Shared
//
//  Created by MADRAFi on 17/07/2022.
//

import SwiftUI

//enum SternikColors {
//
//    static let positive = Color.green
//    static let negative = Color.red
//    static let clean = Color.clear
//}

extension UIColor {
  struct SternikColors {
      static var positive: UIColor  { return UIColor(Color.green) }
      static var negative: UIColor { return UIColor(Color.red) }
      static var clean: UIColor { return UIColor(Color.clear) }
  }
}
struct ContentView: View {
    @ObservedObject var data = DataLoader()
    
    @State public var Answer_A: Bool = false
    @State public var Answer_B: Bool = false
    @State public var Answer_C: Bool = false
    @State public var isAnswered: Bool = false
//    @State public var RowColor : UIColor = UIColor.SternikColors.clean
    
    func checkAnswer() {
        switch  data.questionsData[data.currentCategory].questions[data.currentQuestion].choice {
        case 0:
            isAnswered = false
        case 1:
            isAnswered = true
            Answer_A = true
            Answer_B = false
            Answer_C = false
        case 2:
            isAnswered = true
            Answer_A = false
            Answer_B = true
            Answer_C = false
        case 3:
            isAnswered = true
            Answer_A = false
            Answer_B = false
            Answer_C = true
        default:
            isAnswered = true
        }
    }
    
    func getRowColor(answer: Bool) -> Color {
        var rowcol: Color = Color(UIColor.SternikColors.clean)
//        return answer && isAnswered ? Color(Color.yellow as! CGColor) : Color(Color.clear as! CGColor)
        if isAnswered {
            if data.ValidateAnswer() {
                if answer {
                    rowcol = Color(UIColor.SternikColors.positive)
                } else {
                    rowcol = Color(UIColor.SternikColors.clean)
                }
            } else {
                if answer {
                    rowcol = Color(UIColor.SternikColors.negative)
                } else {
                    rowcol = Color(UIColor.SternikColors.clean)
                }
            }

        } else {
            rowcol = Color(UIColor.SternikColors.clean)
        }
        return rowcol
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

                        ProgressView(value: Float(data.currentQuestion + 1 / data.questionsData[data.currentCategory].questions.count ))
                            .frame(height: 40)
                        Text("Question: " + String(data.currentQuestion + 1 ))
                        Text("Count: " + String(data.questionsData[data.currentCategory].questions.count))
                        
                        Text("V: " + String(Float(1 / 10)))
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
                        data.questionsData[data.currentCategory].questions[data.currentQuestion].choice = 1
                        isAnswered = true
                    }
                    .foregroundColor(.primary)
                    .background(getRowColor(answer: Answer_A))
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
                        data.questionsData[data.currentCategory].questions[data.currentQuestion].choice = 2
                        isAnswered = true
                    }
                    .foregroundColor(.primary)
                    .background(getRowColor(answer: Answer_B))
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
                        data.questionsData[data.currentCategory].questions[data.currentQuestion].choice = 3
                        isAnswered = true
                    }
                    .foregroundColor(.primary)
                    .background(getRowColor(answer: Answer_C))
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

