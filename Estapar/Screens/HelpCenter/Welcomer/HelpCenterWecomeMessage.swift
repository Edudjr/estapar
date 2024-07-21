//
//  HelpCenterWecomeMessage.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 19/07/24.
//

import UIKit
import DeclarativeUIKit

final class HelpCenterWelcomeMessage: UIView {
    private let name: String

    private var body: UIView {
        VerticalStack {
            UILabel()
                .text("Olá, \(name) 👋")

            UILabel()
                .text("Como podemos ajudar?")
        }
        .padding(.all, 15)
        .backgroundColor(.white)
    }

    init(name: String) {
        self.name = name
        super.init(frame: .zero)
        add(body)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
