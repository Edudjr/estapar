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
                UIView().backgroundColor(.blue)
                UIView().backgroundColor(.white)
            }
            .distribution(.fillEqually)

            UIView().backgroundColor(.white).rounded(10)
        }
    }

    init() {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
