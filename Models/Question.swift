//
//  question.swift
//  Sternik
//
//  Created by MADRAFi on 18/07/2022.
//

import Foundation


struct Question: Codable, Identifiable {
    /**
     Static access to the Questions Repository
     */
//    @Injected(\.questions) static var repository
    
    var id: Int {
        get {
            return question_id
        }
        set {
            question_id = newValue
        }
    }
    var question_id: Int
    var question: String
    var question_image: String
    var images: Bool
    var answer_1: String
    var answer_2: String
    var answer_3: String
    var correct: Int
    var choice: Int = 0
    var isFavourite: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case question_id, question, question_image, images, answer_1, answer_2, answer_3, correct
    }
}

/**
 Extension to provide Subscript access to Read and Update Question Models directly from their Repository, with a central reference to the `Question` type:
 ````
 var myQuestion = Question[myQuestionId]
 ````
 */
//extension Question {
//    static subscript(id: Int) -> Question? {
//        get {
//            return Question.repository[id]
//        }
//        set {
//            Question.repository[id] = newValue
//        }
//    }
//}
