//
//  question.swift
//  Sternik
//
//  Created by MADRAFi on 18/07/2022.
//

import Foundation


struct Question: Codable {

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
