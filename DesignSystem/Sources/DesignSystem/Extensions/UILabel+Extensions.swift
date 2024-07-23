//
//  UILabel+Extensions.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 22/07/24.
//

import UIKit

public extension UILabel {
    @discardableResult
    func font(_ font: FontScheme) -> Self {
        self.font = font.uiFont
        return self
    }

    @discardableResult
    func textColor(_ color: ColorScheme = .primaryWhite) -> Self {
        self.textColor = color.uiColor
        return self
    }
}
