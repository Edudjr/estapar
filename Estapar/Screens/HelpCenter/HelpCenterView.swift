//
//  HelpCenterView.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 19/07/24.
//

import UIKit
import DeclarativeUIKit

final class HelpCenterView: UIView {
    var cards = [HelpCenterCardViewModel]()

    var body: UIView {
        CollectionView(cards) { card in
            HelpCenterCard(title: card.title,
                           articlesNumber: card.articlesNumber)
        }
        .header {
            HelpCenterWelcomeMessage(name: "Eduardo")
        }
        .asUIView()
    }

    init(cards: [HelpCenterCardViewModel]) {
        self.cards = cards
        super.init(frame: .zero)
        add(body)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// TODO: move to another file
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
