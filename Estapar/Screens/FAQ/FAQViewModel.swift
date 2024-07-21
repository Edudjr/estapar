//
//  FAQViewModel.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 21/07/24.
//

import Foundation

final class FAQViewModel {
    private let categoryId: String
    private let helpCenter: HelpCenterProtocol

    private var unfilteredItems = [FAQItemViewModel]() {
        didSet {
            items = unfilteredItems
        }
    }
    @Published var appliedSearch = ""
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
            self.unfilteredItems = items.map(FAQItemViewModel.init)
            isLoading = false
        }
    }

    func filterFAQ(containing text: String) {
        self.appliedSearch = text
        self.items = unfilteredItems.filter { $0.contains(text: text) }
    }
}
