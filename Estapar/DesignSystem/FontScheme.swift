//
//  FontScheme.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 22/07/24.
//

import UIKit

/**
 Font scheme from Design System

 Font names are based on the "name" property from [Figma]( https://www.figma.com/design/CGCpZBrAw3zGkmD0Kadygf/Central-de-ajuda---Prova-Mobile?node-id=179-1287&t=ryRGYIheMt237vDk-0).
 */
enum FontScheme {
    case h4
    case small
    case smallBold
    case subtleMedium
    case subtleSemiBold

    var uiFont: UIFont {
        switch self {
        case .h4:
            let size: CGFloat = 24
            let font = UIFont.interFont(ofSize: size, weightValue: 600)
            return font ?? .systemFont(ofSize: size)

        case .small:
            let size: CGFloat = 14
            let font = UIFont.interFont(ofSize: size, weightValue: 500)
            return font ?? .systemFont(ofSize: size)
        
        case .smallBold:
            let size: CGFloat = 16
            let font = UIFont.interFont(ofSize: size, weightValue: 700)
            return font ?? .systemFont(ofSize: size)

        case .subtleMedium:
            let size: CGFloat = 14
            let font = UIFont.interFont(ofSize: size, weightValue: 500)
            return font ?? .systemFont(ofSize: size)

        case .subtleSemiBold:
            let size: CGFloat = 14
            let font = UIFont.interFont(ofSize: size, weightValue: 600)
            return font ?? .systemFont(ofSize: size)
        }
    }
}
