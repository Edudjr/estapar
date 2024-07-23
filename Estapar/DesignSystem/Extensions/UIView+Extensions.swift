//
//  UIView+Extensions.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 23/07/24.
//

import UIKit

extension UIView {
    @discardableResult
    func backgroundColor(_ color: ColorScheme) -> Self {
        self.backgroundColor = color.uiColor
        return self
    }
}
