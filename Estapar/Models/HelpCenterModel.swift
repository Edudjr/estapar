//
//  HelpCenter.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 19/07/24.
//

import Combine

protocol HelpCenterProtocol {
    var headerPublisher: AnyPublisher<Header?, Never> { get }
    var categoriesPublisher: AnyPublisher<[HelpCenterCategory]?, Never> { get }
    var faqItemsPublisher: AnyPublisher<[FAQItem]?, Never> { get }
//    var isLoadingPublisher: AnyPublisher<Bool?, Never> { get }

    func requestCategories() async throws
    func requestFAQItems(forCategoryID: String) async throws
}

/**
 Performs operations related to the Help Center.

 This model is mostly using Published properties because it will be easier to transition to
 SwiftUI in the future.
 */
final class HelpCenterModel: HelpCenterProtocol {
    @Published var header: Header?
    @Published var categories: [HelpCenterCategory]?
    @Published var faqItems: [FAQItem]?

    var headerPublisher: AnyPublisher<Header?, Never> {
        $header.eraseToAnyPublisher()
    }

    var categoriesPublisher: AnyPublisher<[HelpCenterCategory]?, Never> {
        $categories.eraseToAnyPublisher()
    }

    var faqItemsPublisher: AnyPublisher<[FAQItem]?, Never> {
        $faqItems.eraseToAnyPublisher()
    }

    private let api: HelpCenterAPIProtocol

    init(api: HelpCenterAPIProtocol) {
        self.api = api
    }

    func requestCategories() async throws {
        let response = try await api.categories()
        let categories = response.items?.compactMap(HelpCenterCategory.init)
        self.header = response.header.map(Header.init)
        self.categories = categories
    }

    func requestFAQItems(forCategoryID categoryID: String) async throws {
        let response = try await api.faq(forCategoryID: categoryID)
        let items = response.items?.compactMap(FAQItem.init)
        self.faqItems = items
    }
}
