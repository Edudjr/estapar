//
//  FAQItem.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 21/07/24.
//

import DeclarativeUIKit
import UIKit

final class FAQItemView: UIView {
    private(set) var isExpanded = false
    private var item: FAQItemViewModel

    var body: UIView {
        VerticalStack {
            UILabel()
                .text(item.category)
                .font(.boldSystemFont(ofSize: 18))
                .textColor(.blue)
                .onTapGesture { [weak self] in
                    guard let self else { return }
                    self.item.isExpanded.toggle()
                    if self.item.isExpanded {
                        self.expand()
                    } else {
                        self.collapse()
                    }
                }

            itemsStack
                .isHidden(!item.isExpanded)
        }
    }

    lazy var itemsStack: UIView = {
        VerticalStack {
            ForEach(item.questions) { question in
                UILabel().text(question)
            }
        }
    }()

    init(item: FAQItemViewModel) {
        self.item = item
        super.init(frame: .zero)
        add(body)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @discardableResult
    func expand() -> Self {
        animate { [weak self] in
            self?.itemsStack.isHidden(false)
        }

        return self
    }

    @discardableResult
    func collapse() -> Self {
        animate { [weak self] in
            self?.itemsStack.isHidden(true)
        }
        return self
    }

    private func animate(_ handler: @escaping () -> Void) {
        UIView.animate(withDuration: 0.2,
                       delay: 0.0,
                       options: .curveEaseIn,
                       animations: {
            handler()
            self.layoutIfNeeded()
        }) { _ in }
    }
}
