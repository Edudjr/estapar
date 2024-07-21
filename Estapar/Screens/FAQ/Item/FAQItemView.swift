//
//  FAQItem.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 21/07/24.
//

import UIKit

final class FAQItemView: UIView {
    let item: FAQItemViewModel

    var body: UIView {
        UILabel()
            .text(item.category)
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
