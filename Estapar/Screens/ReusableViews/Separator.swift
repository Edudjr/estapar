//
//  Separator.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 22/07/24.
//

import DeclarativeUIKit
import UIKit

final class Separator: UIView {
    var body: UIView {
        UIView()
            .set(\.heightAnchor, to: 1)
            .backgroundColor(.gray100)
            .padding(.all, 4)
    }

    init() {
        super.init(frame: .zero)
        add(body)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
