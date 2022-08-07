//
//  ModelData.swift
//  Sternik
//
//  Created by MADRAFi on 18/07/2022.
//

import Foundation

class DataLoader: ObservableObject {
        
    @Published var questionsData = [questionsList]()
    @Published var currentCategory = 0          // index of a category
    @Published var currentQuestion = 0          // index of a question
//    @Published var currentAnswer = 0

    
    init() {
        load()
//        sort()
    }

    func load() {
        if let fileLocation = Bundle.main.url(forResource: "questions", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let JSONdata = try jsonDecoder.decode([questionsList].self, from: data)
                
                self.questionsData = JSONdata
                
//                print(JSONdata)
            } catch {
                print(error)
            }
        }
    }
    
//    func sort() {
//        self.questionsData = self.questionsData.sorted(by: { $0.question_id < $1.question_id })
//    }

    func ValidateAnswer() -> Bool {
        if questionsData[currentCategory].questions[currentQuestion].correct == questionsData[currentCategory].questions[currentQuestion].choice {
            return true
        } else {
            return false
        }
        
        
    }
}