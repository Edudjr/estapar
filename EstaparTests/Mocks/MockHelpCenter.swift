//
//  MockHelpCenter.swift
//  EstaparTests
//
//  Created by Eduardo Domene Junior on 23/07/24.
//

import Combine
import Foundation
@testable import Estapar

// Mock HelpCenterProtocol
class MockHelpCenter: HelpCenterProtocol {
    var faqItemsPublisher: AnyPublisher<[FAQItem]?, Never> {
        faqItemsSubject.eraseToAnyPublisher()
    }

    var headerPublisher: AnyPublisher<Header?, Never> {
        headerSubject.eraseToAnyPublisher()
    }
    var categoriesPublisher: AnyPublisher<[HelpCenterCategory]?, Never> {
        categoriesSubject.eraseToAnyPublisher()
    }

    var faqItemsSubject = PassthroughSubject<[FAQItem]?, Never>()
    var headerSubject = PassthroughSubject<Header?, Never>()
    var categoriesSubject = PassthroughSubject<[HelpCenterCategory]?, Never>()

    var shouldFailRequestCategories = false

    func requestCategories() async throws {
        if shouldFailRequestCategories {
            throw NSError.mockError
        }
        // Normally, you'd update the subject with new data
//        categoriesSubject.send([HelpCenterCategory(id: "1", name: "Category 1")])
    }

    func requestFAQItems(forCategoryID: String) async throws {
//
    }
}

// Mock UserProtocol
class MockUser: UserProtocol {

    var firstNamePublisher: AnyPublisher<String?, Never> {
        firstNameSubject.eraseToAnyPublisher()
    }

    var surnamePublisher: AnyPublisher<String?, Never> {
        surnameSubject.eraseToAnyPublisher()
    }


    var firstNameSubject = PassthroughSubject<String?, Never>()
    var surnameSubject = PassthroughSubject<String?, Never>()

    var shouldFailRequestUser = false

    func requestUser() async throws {
        if shouldFailRequestUser {
            throw NSError.mockError
        }
        // Normally, you'd update the subject with new data
//        firstNameSubject.send("John")
    }
}
