//
//  Reloadable.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 23/07/24.
//

import DeclarativeUIKit
import UIKit

final class Reloadable: UIView {
    let builder: (() -> UIView)

    init(builder: @escaping () -> UIView) {
        self.builder = builder
        super.init(frame: .zero)
        add(builder())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func reload() {
        subviews.forEach { $0.removeFromSuperview() }
        add(builder())
    }
}
