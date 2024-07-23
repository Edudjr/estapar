//
//  TopNotch.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 22/07/24.
//

import DeclarativeUIKit
import UIKit

final class TopNotch: UIView {
    var body: UIView {
        ZStack {
            VerticalStack {
                UIView().backgroundColor(.zulPrimary700)
                UIView().backgroundColor(.primaryWhite)
            }
            .distribution(.fillEqually)

            UIView().backgroundColor(.primaryWhite).rounded(10)
        }
        .set(\.heightAnchor, to: 20)
    }

    init() {
        super.init(frame: .zero)
        add(body)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
