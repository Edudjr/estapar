//
//  MockHelpCenterAPI.swift
//  EstaparTests
//
//  Created by Eduardo Domene Junior on 23/07/24.
//

import Foundation
@testable import Estapar

class MockHelpCenterAPI: HelpCenterAPIProtocol {
    var stubbedCategoriesResponse: CategoriesResponseDTO?
    var stubbedFAQResponse: FAQResponseDTO?

    func categories() async throws -> CategoriesResponseDTO {
        if let stubbedCategoriesResponse {
            return stubbedCategoriesResponse
        } else {
            throw NSError.mockError
        }
    }

    func faq(forCategoryID categoryID: String) async throws -> FAQResponseDTO {
        if let stubbedFAQResponse {
            return stubbedFAQResponse
        } else {
            throw NSError.mockError
        }
    }
}
