//
//  File.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 21/07/24.
//

struct HelpCenterCategory {
    let id: String
    let title: String
    let articlesNumber: Int
}

extension HelpCenterCategory {
    init?(_ dto: CategoryDTO) {
        guard
            let id = dto.id,
            let title = dto.title,
            let totalArticles = dto.totalArticles
        else {
            return nil
        }
        self.init(id: id,
                  title: title,
                  articlesNumber: totalArticles)
    }
}
