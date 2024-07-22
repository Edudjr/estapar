//
//  ZStack.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 22/07/24.
//

import DeclarativeUIKit
import UIKit

public class ZStack: UIView {
    public init() {
        super.init(frame: CGRect.zero)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public extension ZStack {
    convenience init(@DeclarativeViewBuilder builder: () -> [UIView]) {
        self.init()
        for innerView in builder() {
            add(innerView)
        }
    }
}
