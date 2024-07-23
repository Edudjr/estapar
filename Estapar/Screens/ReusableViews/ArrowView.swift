//
//  ArrowView.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 22/07/24.
//

import DeclarativeUIKit
import UIKit

final class ArrowView: UIView {
    enum Direction {
        case left, right, up, down
    }

    var body: UIView {
        UIImageView(image: UIImage(named: "ArrowRight"))
            .contentMode(.scaleAspectFit)
            .set(\.heightAnchor, to: 16)
            .set(\.widthAnchor, to: 16)
    }

    private let direction: Direction

    init(direction: Direction = .right) {
        self.direction = direction
        super.init(frame: .zero)
        add(body)

        switch direction {
        case .left:
            rotate180DegreesCounterclockwise()
        case .right:
            break
        case .up:
            rotate90DegreesCounterclockwise()
        case .down:
            rotate90DegreesClockwise()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
