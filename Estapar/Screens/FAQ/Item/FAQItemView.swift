//
//  FAQItem.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 21/07/24.
//

import Combine
import DeclarativeUIKit
import UIKit
import DesignSystem

final class FAQItemView: UIView {
    private var viewModel: FAQItemViewModel
    private var isExpandedCancellable: AnyCancellable?

    var body: UIView {
        VerticalStack {
            titleSection

            itemsSection
                .isHidden(!viewModel.isExpanded)
        }
        .spacing(15)
        .padding(.all, 15)
        .bordered()
    }

    var titleSection: UIView {
        HorizontalStack {
            UILabel()
                .text(viewModel.category)
                .font(.subtleSemiBold)
                .textColor(.zulPrimary700)
                .onTapGesture { [weak self] in
                    self?.viewModel.isExpanded.toggle()
                }

            VerticalStack {
                Spacer()
                titleArrow
                Spacer()
            }
        }
    }

    lazy var itemsSection: UIView = {
        VerticalStack {
            Separator()

            ForEach(viewModel.questions) { question in
                HorizontalStack {
                    UILabel()
                        .text(question)
                        .font(.subtleMedium)
                        .textColor(.primaryBlack)
                        .numberOfLines(0)
                    
                    VerticalStack {
                        Spacer()
                        ArrowView()
                        Spacer()
                    }
                }
            }
        }
        .spacing(15)
    }()

    lazy var titleArrow = ArrowView(direction: .down)

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
            .sink { [weak self] isExpanded in
                guard let self else { return }
                if isExpanded {
                    self.expand()
                    self.titleArrow.rotate180DegreesCounterclockwise(animated: true)
                } else {
                    self.collapse()
                    self.titleArrow.rotate180DegreesClockwise(animated: true)
                }
            }
    }

    @discardableResult
    func expand() -> Self {
        animate { [weak self] in
            self?.itemsSection.isHidden(false)
        }

        return self
    }

    @discardableResult
    func collapse() -> Self {
        animate { [weak self] in
            self?.itemsSection.isHidden(true)
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
