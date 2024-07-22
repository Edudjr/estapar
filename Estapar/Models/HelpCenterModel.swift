//
//  HelpCenter.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 19/07/24.
//

protocol HelpCenterProtocol {
    func categories() async throws -> [HelpCenterCategory]
    func faq(forCategoryID: String) async throws -> [FAQItem]
}

final class HelpCenterModel: HelpCenterProtocol {
    private let api: HelpCenterAPIProtocol

    init(api: HelpCenterAPIProtocol) {
        self.api = api
    }

    func categories() async throws -> [HelpCenterCategory] {
        let response = try await api.categories()
        let categories = response.items?.compactMap(HelpCenterCategory.init)
        return categories ?? []
    }

    func faq(forCategoryID categoryID: String) async throws -> [FAQItem] {
        let response = try await api.faq(forCategoryID: categoryID)
        let categories = response.items?.compactMap(FAQItem.init)
        return categories ?? []
    }
}
