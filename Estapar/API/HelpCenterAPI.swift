//
//  ZulAPI.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 21/07/24.
//

import Foundation

protocol HelpCenterAPIProtocol {
    func categories() async throws -> CategoriesResponseDTO
    func faq(forCategoryID: String) async throws -> CategoryIDResponseDTO
}

struct HelpCenterAPI: HelpCenterAPIProtocol {
    let baseURL: URL
    let networkManager: NetworkManagerProtocol

    func categories() async throws -> CategoriesResponseDTO {
        let endpoint = HelpCenterCategoriesEndpoint()
        let response = try await networkManager.request(baseURL: baseURL,
                                                        endpoint: endpoint,
                                                        type: CategoriesResponseDTO.self)
        return response
    }

    func faq(forCategoryID categoryID: String) async throws -> CategoryIDResponseDTO {
        let endpoint = HelpCenterCategoryEndpoint(categoryID: categoryID)
        let response = try await networkManager.request(baseURL: baseURL,
                                                        endpoint: endpoint,
                                                        type: CategoryIDResponseDTO.self)
        return response
    }
}
