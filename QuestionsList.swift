//
//  questionsList.swift
//  Sternik
//
//  Created by MADRAFi on 13/08/2022.
//

import Foundation
import SwiftUI

class QuestionsList: ObservableObject {

    @Published var questions = [categoryList]()

    init() {
        let builtInProduct = Bundle.main.infoDictionary?["BuiltInProduct"] as? String
        load(module: builtInProduct!)
//        sort()
    }

    func load(module: String) {

        // read plist file to get name of the json file
//        guard let questions_file = Bundle.main.infoDictionary?["Questions_File"] as? String
        if let questions_file_modules = Bundle.main.infoDictionary?["Questions_File"] as? [String:String] {
           
            guard let questions_file = questions_file_modules[module]
            else {return print("\(module) not found")}

            if let fileLocation = Bundle.main.url(forResource: questions_file, withExtension: "json") {
                do {
                    let data = try Data(contentsOf: fileLocation)
                    let jsonDecoder = JSONDecoder()
                    let JSONdata = try jsonDecoder.decode([categoryList].self, from: data)

                    self.questions = JSONdata

                } catch {
                    print(error)
                }
            }
        }
        else { return print("Questions_File not found")}

    }

//    func sort() {
//        self.questionsData = self.questionsData.sorted(by: { $0.question_id < $1.question_id })
//    }

    func calculateQuestionsTotal() -> Int {
    // calculates total number of all questions in a set (all categories)

        var value: Int = 0
        for item in questions {
            value += item.questions.count
        }

        return value
    }

    func generateQuestionsList() -> [categoryList] {
    // randomly picks question and add to a new array. New array will have defined numer of elements equal to "exam" in each category
        
//        var set : [categoryList] = questions
        var examSet: [categoryList] = []
        var questions_list: [question] = []
        var element: question
        var questions_all: [question]
        var number: Int
       
        for item in questions {
            number = 0
            questions_list = []
            questions_all = item.questions
            while number < item.exam {
//                print("Losowanie kategoria: \(item.id)")
                questions_all.shuffle()
                element = questions_all.first!
                questions_all.removeFirst()
                questions_list.append(element)
                number += 1
//                print("-- P: \(element.question_id)")
            }
            examSet.append(
                categoryList(
                    id: item.id,
                    category_name: item.category_name,
                    exam: item.exam,
                    questions: questions_list.sorted(by: { $0.question_id < $1.question_id })
                )
            )
        }
        return examSet
    }
    
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
