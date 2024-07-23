//
//  UserModel.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 23/07/24.
//

import Combine

protocol UserProtocol {
    var firstNamePublisher: AnyPublisher<String?, Never> { get }
    var surnamePublisher: AnyPublisher<String?, Never> { get }

    func requestUser() async throws
}

/**
 Performs operations related to the User, like fetching its name.

 This model is mostly using Published properties because it will be easier to transition to
 SwiftUI in the future.
 */
final class UserModel: UserProtocol {
    @Published var firstName: String?
    @Published var surname: String?

    var firstNamePublisher: AnyPublisher<String?, Never> {
        $firstName.eraseToAnyPublisher()
    }
    var surnamePublisher: AnyPublisher<String?, Never> {
        $surname.eraseToAnyPublisher()
    }

    // Fake a network request
    func requestUser() async throws {
        try? await Task.sleep(for: .seconds(1))
        self.firstName = "John"
        self.surname = "Doe"
    }
}
