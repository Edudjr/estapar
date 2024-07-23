//
//  HelpCenterViewModelTests.swift
//  EstaparTests
//
//  Created by Eduardo Domene Junior on 23/07/24.
//

import Combine
import XCTest
@testable import Estapar

final class HelpCenterViewModelTests: XCTestCase {
    var viewModel: HelpCenterViewModel!
    var mockHelpCenter: MockHelpCenter!
    var mockUser: MockUser!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockHelpCenter = MockHelpCenter()
        mockUser = MockUser()
        viewModel = HelpCenterViewModel(helpCenter: mockHelpCenter, user: mockUser)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockHelpCenter = nil
        mockUser = nil
        cancellables = nil
        super.tearDown()
    }

    func testInitializationAndBinding() {
        XCTAssertNotNil(viewModel.helpCenter)
        XCTAssertNotNil(viewModel.user)
    }

    func testSuccessfulLoadCategories() {
        let expectation = XCTestExpectation(description: "Categories loaded successfully")

        viewModel.$categories
            .dropFirst()
            .sink { categories in
                XCTAssertFalse(categories.isEmpty)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        let category = HelpCenterCategory(.mock())!
        mockHelpCenter.categoriesSubject.send([category])

        wait(for: [expectation], timeout: 1.0)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testFailedLoadCategories() {
        let expectation = XCTestExpectation(description: "Categories load failed")

        mockHelpCenter.shouldFailRequestCategories = true

        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertEqual(errorMessage, "Houve um erro ao buscar a Central de Ajuda")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        mockHelpCenter.shouldFailRequestCategories = true
        viewModel.loadCategories()

        wait(for: [expectation], timeout: 1.0)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.errorMessage, EstaparError.categoriesError.errorDescription)
    }

    func testSuccessfulLoadHeader() {
        let expectation = XCTestExpectation(description: "Header loaded successfully")

        viewModel.$helloUserMessage
            .dropFirst()
            .sink { message in
                XCTAssertEqual(message, "hello Jane")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        let header = Header(.mock())
        mockHelpCenter.headerSubject.send(header)
        mockUser.firstNameSubject.send("Jane")

        wait(for: [expectation], timeout: 1.0)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testFailedLoadHeader() {
        let expectation = XCTestExpectation(description: "Header load failed")

        mockUser.shouldFailRequestUser = true

        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertEqual(errorMessage, "Houve um erro ao buscar a Central de Ajuda")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        mockUser.shouldFailRequestUser = true
        viewModel.loadHeader()

        wait(for: [expectation], timeout: 0.2)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.errorMessage, EstaparError.categoriesError.errorDescription)
    }

    func testHelloUserMessageUpdate() {
        let expectation = XCTestExpectation(description: "Hello user message updated")

        viewModel.$helloUserMessage
            .dropFirst()
            .sink { message in
                XCTAssertEqual(message, "Olá, John 👋" )
                expectation.fulfill()
            }
            .store(in: &cancellables)

        let dto = HeaderDTO(image: nil, line1: "Olá, %firstName% 👋", line2: nil)
        mockHelpCenter.headerSubject.send(Header(dto))
        mockUser.firstNameSubject.send("John")

        wait(for: [expectation], timeout: 1.0)
    }

    func testCanWeHelpMessageUpdate() {
        let expectation = XCTestExpectation(description: "Can we help message updated")

        viewModel.$canWeHelpMessage
            .dropFirst()
            .sink { message in
                XCTAssertEqual(message, "How can we help you?" )
                expectation.fulfill()
            }
            .store(in: &cancellables)

        let dto = HeaderDTO(image: nil, line1: nil, line2: "How can we help you?")
        mockHelpCenter.headerSubject.send(Header(dto))
        mockUser.firstNameSubject.send("Jane")

        wait(for: [expectation], timeout: 1.0)
    }

    func testHeaderBackgroundImageUpdate() {
        let expectation = XCTestExpectation(description: "Header background image updated")

        viewModel.$headerBackgroundImage
            .dropFirst()
            .sink { image in
                XCTAssertEqual(image, "https://google.com")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        let imageDTO = ImageDTO.mock()
        let dto = HeaderDTO(image: imageDTO, line1: nil, line2: nil)
        mockHelpCenter.headerSubject.send(Header(dto))
        mockUser.firstNameSubject.send("Jane")

        wait(for: [expectation], timeout: 1.0)
    }

    func testCategoriesUpdate() {
        let expectation = XCTestExpectation(description: "Categories updated")

        viewModel.$categories
            .dropFirst()
            .sink { categories in
                XCTAssertEqual(categories.count, 1)
                XCTAssertEqual(categories.first?.categoryId, "id")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        let dto = HelpCenterCategory(id: "id", title: "title", articlesNumber: 10)
        mockHelpCenter.categoriesSubject.send([dto])

        wait(for: [expectation], timeout: 1.0)
    }
}
