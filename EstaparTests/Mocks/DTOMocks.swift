//
//  DTOMocks.swift
//  EstaparTests
//
//  Created by Eduardo Domene Junior on 23/07/24.
//

import Foundation
@testable import Estapar

extension CategoriesResponseDTO {
    static func example1() throws -> Self {
        try getCategoriesExample1.decode(to: Self.self)
    }
}

extension FAQResponseDTO {
    static func example1() throws -> Self {
        try getFAQExample1.decode(to: Self.self)
    }
}

extension HeaderDTO {
    static func mock() -> Self {
        HeaderDTO(image: .mock(),
                  line1: "hello %firstName%",
                  line2: "line2")
    }
}

extension ImageDTO {
    static func mock() -> Self {
        ImageDTO(oneX: "https://google.com",
                 twoX: "https://google.com",
                 threeX: "https://google.com")
    }
}

extension CategoryDTO {
    static func mock() -> Self {
        CategoryDTO(id: "id",
                    title: "title",
                    category: "category",
                    totalArticles: 10)
    }
}

extension String {
    func decode<T: Decodable>(to type: T.Type) throws -> T {
        guard let data = data(using: .utf8) else { throw NSError.mockError }
        let decoded = try JSONDecoder().decode(T.self, from: data)
        return decoded
    }
}

extension NSError {
    static var mockError: Error {
        NSError(domain: "TestError", code: -1, userInfo: nil)
    }
}
