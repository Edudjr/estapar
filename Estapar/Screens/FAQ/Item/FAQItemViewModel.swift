//
//  FAQItemViewModel.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 21/07/24.
//

import Foundation

struct FAQItemViewModel {
    let category: String
    let questions: [String]
}

extension FAQItemViewModel {
    init(_ item: FAQItem) {
        self.init(category: item.category,
                  questions: item.questions)
    }
}
