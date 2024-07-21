//
//  FAQItem.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 21/07/24.
//

import DeclarativeUIKit
import UIKit

final class FAQItemView: UIView {
    let item: FAQItemViewModel

    var body: UIView {
        VerticalStack {
            UILabel()
                .text(item.category)
                .font(.boldSystemFont(ofSize: 18))
                .textColor(.blue)
                .onTapGesture { [weak self] in
                    self?.itemsStack.isHidden.toggle()
                }

            itemsStack
                .isHidden(true)
        }
    }

    var itemsStack: VerticalStack {
        VerticalStack {
            ForEach(item.questions) { question in
                UILabel().text(question)
            }
        }
    }

    init(item: FAQItemViewModel) {
        self.item = item
        super.init(frame: .zero)
        add(body)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
