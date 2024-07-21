//
//  FAQItemViewModel.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 21/07/24.
//

import Foundation

final class FAQItemViewModel {
    var isExpanded = false
    let category: String
    let questions: [String]

    init(isExpanded: Bool = false, category: String, questions: [String]) {
        self.isExpanded = isExpanded
        self.category = category
        self.questions = questions
    }

    func contains(text: String) -> Bool {
        guard let regex = try? Regex(".*\(text.uppercased()).*") else { return false }
        let containsInCategory = category.uppercased().contains(regex)
        let containsInQuestions = questions.contains { $0.uppercased().contains(regex) }
        return containsInCategory || containsInQuestions
    }
}

extension FAQItemViewModel {
    convenience init(_ item: FAQItem) {
        self.init(category: item.category,
                  questions: item.questions)
    }
}
