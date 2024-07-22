//
//  Environment.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 21/07/24.
//

import Foundation

enum Environment {
    case development
    case production

    static var current: Self {
        #if DEBUG
        return .development
        #else
        return .production
        #endif
    }
}
