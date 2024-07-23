//
//  HelpCenterWecomeMessage.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 19/07/24.
//

import UIKit
import DeclarativeUIKit
import DesignSystem

final class HelpCenterWelcomeMessage: UIView {
    private let line1: String
    private let line2: String

    private var body: UIView {
        VerticalStack {
            UILabel()
                .text(line1)
                .font(.h4)
                .textColor(.zulPrimary200)

            UILabel()
                .text(line2)
                .font(.h4)
                .textColor(.primaryWhite)
        }
        .padding(.all, 15)
    }

    init(line1: String, line2: String) {
        self.line1 = line1
        self.line2 = line2
        super.init(frame: .zero)
        add(body)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
