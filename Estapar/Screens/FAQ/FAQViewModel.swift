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

    @Published var appliedSearch = "" {
        didSet {
            filterFAQ(containing: appliedSearch)
        }
    }

    @Published var items = [FAQItemViewModel]()
    @Published var isLoading = true

    init(categoryId: String, helpCenter: HelpCenterProtocol) {
        self.categoryId = categoryId
        self.helpCenter = helpCenter
        loadItems()
    }

    func loadItems() {
//        Task {
//            isLoading = true
//            do {
//                let items = try await helpCenter.faq(forCategoryID: categoryId)
//                self.unfilteredItems = items.map(FAQItemViewModel.init)
//            } catch {
//                // TODO: handle error
//                print(error)
//            }
//            isLoading = false
//        }
    }

    private func filterFAQ(containing text: String) {
        self.items = unfilteredItems.filter { $0.contains(text: text) }
    }
}
