//
//  ScrollView+Extensions.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 19/07/24.
//

import UIKit
import DeclarativeUIKit

public extension ScrollView {
    @discardableResult
    func bounces(_ shouldBounce: Bool) -> Self {
        self.bounces = shouldBounce
        return self
    }
}
