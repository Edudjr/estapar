//
//  HelpCenterCategoryViewModel.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 19/07/24.
//

struct HelpCenterCategoryViewModel {
    let categoryId: String
    let title: String
    let articlesNumber: Int
}

extension HelpCenterCategoryViewModel {
    init(category: HelpCenterCategory) {
        self.init(categoryId: category.id,
                  title: category.title,
                  articlesNumber: category.articlesNumber)
    }
}
