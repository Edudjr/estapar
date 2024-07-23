//
//  ColorScheme.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 22/07/24.
//

import UIKit

/**
 Color scheme from Design System.

 Color names are based on the "Colors" property from [Figma]( https://www.figma.com/design/CGCpZBrAw3zGkmD0Kadygf/Central-de-ajuda---Prova-Mobile?node-id=179-1287&t=ryRGYIheMt237vDk-0).
 */
public enum ColorScheme {
    case primaryWhite
    case primaryBlack
    case zulPrimary200
    case zulPrimary700
    case gray400

    public var uiColor: UIColor {
        switch self {
        case .primaryWhite:
            UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        case .primaryBlack:
            UIColor(red: 18, green: 18, blue: 18, alpha: 1)
        case .zulPrimary200:
            UIColor(red: 176, green: 197, blue: 251, alpha: 1)
        case .zulPrimary700:
            UIColor(red: 0, green: 63, blue: 225, alpha: 1)
        case .gray400:
            UIColor(red: 156, green: 163, blue: 175, alpha: 1)
        }
    }
}
