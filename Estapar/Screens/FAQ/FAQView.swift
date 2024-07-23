//
//  FAQView.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 20/07/24.
//

import Combine
import UIKit
import DeclarativeUIKit
import DesignSystem

final class FAQView: UIView {
    private let viewModel: FAQViewModel
    private var isLoadingCancellable: AnyCancellable?
    private var itemsCancellable: AnyCancellable?
    private var isEditting = false

    var body: UIView {
        if viewModel.isLoading {
            LoadingView()
        } else {
            ScrollView(.vertical) {
                VerticalStack {
                    UILabel()
                        .text("Perguntas frequentes")
                        .font(.smallBold)
                        .textColor(.primaryBlack)
                        .padding(.bottom, 20)

                    TextFieldView()
                        .placeholder("Pesquisar")
                        .text(viewModel.appliedSearch)
                        .onEdit { [weak self] text in
                            self?.viewModel.appliedSearch = text
                            self?.isEditting = true
                        }
                        .focus(isEditting)
                        .padding(.bottom, 15)

                    reloadableItems
                }
            }
            .showsVerticalScrollIndicator(false)
            .padding(.all, 16)
            .fadeIn()
        }
    }

    lazy var reloadableItems: Reloadable = {
        Reloadable { [weak self] in
            VerticalStack {
                ForEach(self?.viewModel.items ?? []) { item in
                    FAQItemView(viewModel: item)
                        .padding(.vertical, 4)
                }
            }
        }
    }()

    init(viewModel: FAQViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        add(body).backgroundColor(.primaryWhite)
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
                self.reloadableItems.reload()
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
