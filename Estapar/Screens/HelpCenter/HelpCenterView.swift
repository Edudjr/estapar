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
            VerticalStack {
                UILabel()
                    .text("Olá, Eduardo 👋")

                UILabel()
                    .text("Como podemos ajudar?")
            }
            .padding(.vertical, 10)
        }
        .asUIView()
    }

//    var body: UIView {
//        ScrollView(.vertical) {
//            VerticalStack {
//
//                UILabel()
//                    .text("Olá, Eduardo 👋")
//                    .padding(.top, 40)
//
//                UILabel()
//                    .text("Como podemos ajudar?")
//                    .padding(.bottom, 40)
//
//                CollectionView(cards) { card in
//                    HelpCenterCard(title: card.title,
//                                   articlesNumber: card.articlesNumber)
//                }
//                .asUIView()
//                .set(\.heightAnchor, to: UIScreen.main.bounds.height * 0.8)
//            }
//        }
//        .bounces(false)
//    }

    init(cards: [HelpCenterCardViewModel]) {
        self.cards = cards
        super.init(frame: .zero)
        reloadView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func reloadView() {
        subviews.forEach { $0.removeFromSuperview() }
        add(body)
    }
}

// TODO: move to another file
extension UIViewController {
    func asUIView() -> UIView {
        ViewControllerHost {
            self
        }
    }
}

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

public extension ScrollView {
    @discardableResult
    func bounces(_ shouldBounce: Bool) -> Self {
        self.bounces = shouldBounce
        return self
    }
}
