//
//  LoadingView.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 19/07/24.
//

import DeclarativeUIKit
import UIKit

class LoadingView: UIView {
    lazy var body: UIView = {
        VerticalStack {
            Spacer()
            UILabel()
                .text("Loading ...")
            Spacer()
        }
        .backgroundColor(.white.withAlphaComponent(0.8))
    }()

    init() {
        super.init(frame: .zero)
        add(body)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
