//
//  question.swift
//  Sternik
//
//  Created by MADRAFi on 18/07/2022.
//

import Foundation


struct question: Codable {

    var question_id: Int
    var question: String
    var question_image: String
    var images: Bool
    var answer_1: String
    var answer_2: String
    var answer_3: String
    var correct: Int
    var choice: Int = 0
    
    private enum CodingKeys: String, CodingKey {
        case question_id, question, question_image, images, answer_1, answer_2, answer_3, correct
    }
}

struct categoryList: Codable, Identifiable {
    var id: Int
    var category_name: String
    var exam: Int
    var questions: [question]
}

extension categoryList {

    static func example_data() -> [categoryList] {
        return [
            categoryList(
                id: 1,
                category_name: "Regulaminy",
                exam: 1,
                questions: [
                    question(
                        question_id: 1,
                        question: "Zgodnie z kolejnością pierwszeństwa łączności:",
                        question_image: "",
                        images: false,
                        answer_1: "łączność ostrzegawcza ma pierwszeństwo przed łącznością pilną",
                        answer_2: "łączność ostrzegawcza ma pierwszeństwo przed łącznością publiczną",
                        answer_3: "łączność pilna ma pierwszeństwo przed łącznością w niebezpieczeństwie",
                        correct: 2
                    )
                ]
            ),
            categoryList(
                id: 2,
                category_name: "Terminy anglojęzyczne",
                exam: 1,
                questions: [
                    question(
                        question_id: 115,
                        question: "Potrzebuję asysty.",
                        question_image: "",
                        images: false,
                        answer_1: "I require assistance.",
                        answer_2: "I require escort.",
                        answer_3: "I need attention.",
                        correct: 2
                    ),
                    question(
                        question_id: 116,
                        question: "Pożar w nadbudówce.",
                        question_image: "",
                        images: false,
                        answer_1: "Superstructure is fireing.",
                        answer_2: "I am having fire in superstructure.",
                        answer_3: "Superstructure on fire.",
                        correct: 3
                    )
                ]
            )
            
        ]
    }
}
