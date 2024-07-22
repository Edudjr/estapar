//
//  FAQItem.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 21/07/24.
//

struct FAQItem {
    let category: String
    let questions: [String]
}

extension FAQItem {
    init?(_ dto: FAQSectionDTO) {
        guard
            let category = dto.title,
            let questions = dto.items?.compactMap(\.title)
        else {
            return nil
        }
        self.init(category: category,
                  questions: questions)
    }
}
