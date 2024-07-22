//
//  ColorScheme.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 22/07/24.
//

import UIKit

enum ColorScheme {
    case primary
    case zulPrimary200

    var uiColor: UIColor {
        switch self {
        case .primary:
            UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        case .zulPrimary200:
            UIColor(red: 176, green: 197, blue: 251, alpha: 1)
        }
    }
}
