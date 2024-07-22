//
//  FontScheme.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 22/07/24.
//

import UIKit

enum FontScheme {
    case h4

    var uiFont: UIFont {
        switch self {
        case .h4:
            let font = UIFont.systemFont(ofSize: 24, weight: .init(600))
            // Adjust other things like line height.
            return font
        }
    }
}
