//
//  HelpCenterCardViewModel.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 19/07/24.
//

struct HelpCenterCardViewModel {
    let title: String
    let articlesNumber: Int
}

extension HelpCenterCardViewModel {
    init(category: HelpCenterCategory) {
        self.init(title: category.title,
                  articlesNumber: category.articlesNumber)
    }
}
