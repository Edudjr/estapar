//
//  HelpCenterModelTests.swift
//  EstaparTests
//
//  Created by Eduardo Domene Junior on 23/07/24.
//

import XCTest
import Combine
@testable import Estapar

final class HelpCenterModelTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = []

    func testRequestCategoriesSuccess() async throws {
        let mockAPI = MockHelpCenterAPI()

        mockAPI.stubbedCategoriesResponse = try .example1()

        let sut = HelpCenterModel(api: mockAPI)

        let expectation = XCTestExpectation(description: "Categories Published")

        sut.$categories
            .dropFirst()
            .sink { categories in
                XCTAssertEqual(categories?.count, 2)
                XCTAssertEqual(categories?.first?.id, "9530181")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        try await sut.requestCategories()

        await fulfillment(of: [expectation])
    }

    func testRequestCategoriesHeaderSuccess() async throws {
        let mockAPI = MockHelpCenterAPI()

        mockAPI.stubbedCategoriesResponse = try .example1()

        let sut = HelpCenterModel(api: mockAPI)

        let expectation = XCTestExpectation(description: "Categories Published")

        sut.$header
            .dropFirst()
            .sink { header in
                XCTAssertEqual(header?.line1, "Olá, %firstName% 👋")
                XCTAssertEqual(header?.line2, "Como podemos ajudar?")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        try await sut.requestCategories()

        await fulfillment(of: [expectation])
    }

    func testRequestFAQItemsSuccess() async throws {
        let mockAPI = MockHelpCenterAPI()
        mockAPI.stubbedFAQResponse = try .example1()

        let model = HelpCenterModel(api: mockAPI)

        let expectation = XCTestExpectation(description: "FAQ Items Published")

        model.$faqItems
            .dropFirst()
            .sink { faqItems in
                XCTAssertEqual(faqItems?.count, 2)
                XCTAssertEqual(faqItems?.first?.category, "Pagamento de tíquete")
                XCTAssertEqual(faqItems?.first?.questions.count, 2)
                XCTAssertEqual(faqItems?.first?.questions.first, "Não consegui pagar o tíquete do estacionamento pelo Zul+. E agora?")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        try await model.requestFAQItems(forCategoryID: "1")

        await fulfillment(of: [expectation])
    }
}
