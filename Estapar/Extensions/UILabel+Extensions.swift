//
//  UILabel+Extensions.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 22/07/24.
//

import UIKit

extension UILabel {
    @discardableResult
    func font(_ font: FontScheme) -> Self {
        self.font(font.uiFont)
    }

    @discardableResult
    func textColor(_ color: ColorScheme = .primary) -> Self {
        self.textColor(color.uiColor)
    }
}
