//
//  FAQItem.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 21/07/24.
//

import Combine
import DeclarativeUIKit
import UIKit

final class FAQItemView: UIView {
    private(set) var isExpanded = false
    private var viewModel: FAQItemViewModel
    private var isExpandedCancellable: AnyCancellable?

    var body: UIView {
        VerticalStack {
            UILabel()
                .text(viewModel.category)
                .font(.boldSystemFont(ofSize: 18))
                .textColor(.blue)
                .onTapGesture { [weak self] in
                    self?.viewModel.isExpanded.toggle()
                }

            itemsStack
                .isHidden(!viewModel.isExpanded)
        }
    }

    lazy var itemsStack: UIView = {
        VerticalStack {
            ForEach(viewModel.questions) { question in
                UILabel().text(question)
            }
        }
    }()

    init(viewModel: FAQItemViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        add(body)
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bind() {
        isExpandedCancellable = viewModel.$isExpanded
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink { isExpanded in
                if isExpanded {
                    self.expand()
                } else {
                    self.collapse()
                }
            }
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
