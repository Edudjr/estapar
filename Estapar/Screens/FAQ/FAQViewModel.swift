//
//  FAQViewModel.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 21/07/24.
//

import Combine
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

    private var cancellables = Set<AnyCancellable>()

    init(categoryId: String, helpCenter: HelpCenterProtocol) {
        self.categoryId = categoryId
        self.helpCenter = helpCenter
        bind()
        loadItems()
    }

    func loadItems() {
        helpCenter.requestFAQItems(forCategoryID: categoryId)
    }

    private func bind() {
        helpCenter.faqItemsPublisher
            .compactMap { $0 }
            .sink { [weak self] items in
                self?.items = items.map(FAQItemViewModel.init)
            }
            .store(in: &cancellables)

        helpCenter.isLoadingPublisher
            .compactMap { $0 }
            .sink { [weak self] isLoading in
                self?.isLoading = isLoading
            }
            .store(in: &cancellables)
    }

    private func filterFAQ(containing text: String) {
        self.items = unfilteredItems.filter { $0.contains(text: text) }
    }
}
