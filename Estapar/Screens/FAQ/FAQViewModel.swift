//
//  FAQViewModel.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 21/07/24.
//

import Foundation

final class FAQViewModel {
    let categoryId: String
    let helpCenter: HelpCenterProtocol
    
    @Published var items = [FAQItemViewModel]()
    @Published var isLoading = true

    init(categoryId: String, helpCenter: HelpCenterProtocol) {
        self.categoryId = categoryId
        self.helpCenter = helpCenter
    }

    func loadItems() {
        Task {
            isLoading = true
            let items = await helpCenter.faq(forCategoryId: categoryId)
            self.items = items.map(FAQItemViewModel.init)
            isLoading = false
        }
    }
}
