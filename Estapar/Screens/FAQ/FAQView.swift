//
//  FAQView.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 20/07/24.
//

import Combine
import UIKit
import DeclarativeUIKit

final class FAQView: UIView {
    private let viewModel: FAQViewModel
    private var isLoadingCancellable: AnyCancellable?
    private var itemsCancellable: AnyCancellable?

    var body: UIView {
        if viewModel.isLoading {
            LoadingView()
        } else {
            VerticalStack {
                UILabel()
                    .text("Perguntas frequentes")
                    .font(.boldSystemFont(ofSize: 18))
                    .padding(.bottom, 20)

                TextFieldView()
                    .text(viewModel.appliedSearch)
                    .onEdit { [weak self] text in
                        self?.viewModel.appliedSearch = text
                    }
                    .focus()

                ForEach(viewModel.items) { item in
                    FAQItemView(viewModel: item)
                }

                Spacer()
            }
        }
    }

    init(viewModel: FAQViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        add(body).backgroundColor(.white)
        bind()
        loadItems()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bind() {
        itemsCancellable = viewModel.$items
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.reload()
            }
        isLoadingCancellable = viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.reload()
            }
    }

    private func reload() {
        subviews.forEach { $0.removeFromSuperview() }
        add(body)
    }

    private func loadItems() {
        viewModel.loadItems()
    }
}
