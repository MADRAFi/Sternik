//
//  CategoryList.swift
//  Sternik
//
//  Created by Simon Stuart on 31/08/2022.
//

import Foundation

enum CategoryType {
    case id(Int)
    case favourites
    case all
    case exam
}

struct Category: Codable, Identifiable {
    @Injected(\.categories) static var repository
    
    var id: Int
    var category_name: String
    var exam: Int
    var questions: [Question]
}

extension Category {

    static subscript(id: Int) -> Category? {
        get {
            return Category.repository[id]
        }
        set {
            Category.repository[id] = newValue
            
        }
    }
    
    static func example_data() -> [Category] {
        return [
            Category(
                id: 1,
                category_name: "Regulaminy",
                exam: 1,
                questions: [
                    Question(
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
            Category(
                id: 2,
                category_name: "Terminy anglojęzyczne",
                exam: 1,
                questions: [
                    Question(
                        question_id: 115,
                        question: "Potrzebuję asysty.",
                        question_image: "",
                        images: false,
                        answer_1: "I require assistance.",
                        answer_2: "I require escort.",
                        answer_3: "I need attention.",
                        correct: 2
                    ),
                    Question(
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
