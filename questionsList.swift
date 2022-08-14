//
//  questionsList.swift
//  Sternik
//
//  Created by MADRAFi on 13/08/2022.
//

import Foundation

class QuestionsList: ObservableObject {

    @Published var questions = [categoryList]()

    init() {
        load()
//        sort()
    }

    func load() {

        // read plist file to get name of the json file
        guard let questions_file = Bundle.main.infoDictionary?["Questions_File"] as? String
        else {return print("Questions_File not found")}

        if let fileLocation = Bundle.main.url(forResource: questions_file, withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let JSONdata = try jsonDecoder.decode([categoryList].self, from: data)

                self.questions = JSONdata

//                print(JSONdata)
            } catch {
                print(error)
            }
        }

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
        var examSet: [categoryList] = []
        var element: categoryList
        var number: Int = 1
        
        for item in questions {
            while number < item.exam {
                element = questions.randomElement()!
                if !examSet.contains(where: { $0.id == element.id }) {
                    examSet.append(element)
                    number += 1
                }
            }
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
