//
//  CategoryRepository.swift
//  Sternik
//
//  Created by MADRAFi on 13/08/20 22.
//

import Foundation
import SwiftUI

class CategoryRepository: ObservableObject {
    @Published var categories = [Category.ID:Category]() {
        didSet {
            sortedCategories = categories.values.sorted(by: { lhs, rhs in
                lhs.id < rhs.id
            })
//            sortedCategories = sortCategories()
            favourites = filterFavourites()
        }
    }

    var sortedCategories = [Category]()
    var favourites = [Category]()
    
    /**
     This Subscript allows us to Get and Set Questions by referencing the Repository itself, rather than a property or method
     */
    subscript(id: Category.ID) -> Category? {
        get {
            return categories[id]
        }
        set {
            objectWillChange.send()
            categories[id] = newValue

        }
    }

    init() {
        let builtInProduct = Bundle.main.infoDictionary?["BuiltInProduct"] as? String
        load(module: builtInProduct!)
    }

    /**
     Load the Categories from the given `module` File
     */
    func load(module: String) {

        // read plist file to get name of the json file
//        guard let questions_file = Bundle.main.infoDictionary?["Questions_File"] as? String
        if let questions_file_modules = Bundle.main.infoDictionary?["Questions_Files"] as? [String:String] {
           
            guard let questions_file = questions_file_modules[module]
            else {return print("\(module) not found")}

            if let fileLocation = Bundle.main.url(forResource: questions_file, withExtension: "json") {
                do {
                    let data = try Data(contentsOf: fileLocation)
                    let jsonDecoder = JSONDecoder()
                    let questions = try jsonDecoder.decode([Category].self, from: data)

                    /**
                    Added by Simon... this code populates the `questions` Dictionary from the `JSONdata` Array
                     */
                    for question in questions {
                        self.categories[question.id] = question
                    }

                } catch {
                    print(error)
                }
            }
        }
        else { return print("Questions_Files not found")}

    }

    /**
     randomly picks question and add to a new array. New array will have defined number of elements equal to "exam" in each category
     */
    func generateQuestionsList() -> [Category] {
        var examSet: [Category] = []
        var questions_list: [Question] = []
        var element: Question
        var questions_all: [Question]
        var number: Int
       
        for item in categories.values {
            var category = item /// Take a Copy of the Category here
            number = 0
            questions_list = []
            questions_all = item.questions
            if questions_all.count == 0 { continue } // If there are no Questions... skip this Category!
            while number < item.exam {
                if questions_all.first != nil {
                    //                print("Losowanie kategoria: \(item.id)")
                    questions_all.shuffle()
                    element = questions_all.first!
                    questions_all.removeFirst()
                    questions_list.append(element)
                }
                number += 1
                //                print("-- P: \(element.question_id)")
            }
            category.questions = questions_list /// Replace its Question List with the results of the above
            examSet.append(category) /// Append the mutated Copy of the Category to the resulting `examSet`
            examSet.sort(by: { $0.id < $1.id })
        }
        return examSet
    }
    
    /**
     Returns all `Category` models where `isFavorite` == `true`
     */
    func filterFavourites() -> [Category] {
        var results = [Category]() // Empty Results Array of Categories
        for category in categories.values {
            var thisCategory = category /// Take a copy because we're going to mutate it!
            thisCategory.questions = category.questions.filter( { $0.isFavourite } ) /// Set the Copy's Questions to an Array of only those where `.isFavourite == true`
            if thisCategory.questions.count == 0 { continue } /// If there are no Favourite Questions, move on to the next Category
            // If we reach this line, we have only Favourite Questions for this Category....
            results.append(thisCategory) /// ... so let's add this filtered Category to the output Array
        }
            results.sort(by: {$0.id < $1.id })
        return results
    }
    
//    func sortCategories() -> [Category] {
//        var results = [Category]()
//        for category in categories.values {
//            results.append(category)
//        }
//        results.sort(by: {$0.id < $1.id })
//        return results
//    }
    
    static func example_data() -> [Category] {
        return [
            Category(
                id: 1,
                category_name: "Regulaminy",
                exam: 1,
                questions: [
                    Question(
                        question_id: 1,
                        question: "Zgodnie z kolejno??ci?? pierwsze??stwa ????czno??ci:",
                        question_image: "",
                        images: false,
                        answer_1: "????czno???? ostrzegawcza ma pierwsze??stwo przed ????czno??ci?? piln??",
                        answer_2: "????czno???? ostrzegawcza ma pierwsze??stwo przed ????czno??ci?? publiczn??",
                        answer_3: "????czno???? pilna ma pierwsze??stwo przed ????czno??ci?? w niebezpiecze??stwie",
                        correct: 2
                    )
                ]
            ),
            Category(
                id: 2,
                category_name: "Terminy angloj??zyczne",
                exam: 1,
                questions: [
                    Question(
                        question_id: 115,
                        question: "Potrzebuj?? asysty.",
                        question_image: "",
                        images: false,
                        answer_1: "I require assistance.",
                        answer_2: "I require escort.",
                        answer_3: "I need attention.",
                        correct: 2
                    ),
                    Question(
                        question_id: 116,
                        question: "Po??ar w nadbud??wce.",
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

/**
 Injects your CategoryRepository so that you can access it from anywhere
 */
private struct TheKey: InjectionKey {
     static var currentValue: CategoryRepository = CategoryRepository()
}

extension InjectedValues {
    /**
     Adds the Injection Key universally in your code. You can now do:
     ````
     @Injected(\.categories) var categories
     ````
     And you have a variable of type `CategoryRepository` containing the singular, central Instance.
     */
    var categories: CategoryRepository {
        get { Self[TheKey.self] }
        set { Self[TheKey.self] = newValue }
    }
}
