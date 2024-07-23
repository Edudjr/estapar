//
//  EstaparError.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 23/07/24.
//

import Foundation

enum EstaparError: LocalizedError {
    case faqItemsError
    case categoriesError

    var errorDescription: String? {
        switch self {
        case .faqItemsError:
            "Houve um erro ao buscar o FAQ"
        case .categoriesError:
            "Houve um erro ao buscar a Central de Ajuda"
        }
    }
}
