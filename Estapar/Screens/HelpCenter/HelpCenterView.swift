//
//  HelpCenterView.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 19/07/24.
//

import Combine
import UIKit
import DeclarativeUIKit
final class HelpCenterView: UIView {

    private let viewModel: HelpCenterViewModel
    private var isLoadingCancellable: AnyCancellable?

    var body: UIView {
        if viewModel.isLoading {
            LoadingView()
        } else {
            CollectionView(viewModel.categories) { category in
                HelpCenterCategoryView(viewModel: category)
                    .onTapGesture { [weak self] in
                        guard let self else { return }
                        let viewModel = FAQViewModel(categoryId: category.categoryId,
                                                     helpCenter: self.viewModel.helpCenter)
                        let faq = FAQView(viewModel: viewModel)
                        self.show(faq)
                    }
            }
            .header(backgroundImageURL: viewModel.headerBackgroundImage) { [weak self] in
                HelpCenterWelcomeMessage(line1: self?.viewModel.helloUserMessage ?? "",
                                         line2: self?.viewModel.canWeHelpMessage ?? "")
            }
            .asUIView()
            .backgroundColor(.primaryWhite)
            .fadeIn()
        }
    }

    init(viewModel: HelpCenterViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        title("Central de ajuda")
        add(body)
        bind()
        loadCategories()
        loadHeader()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bind() {
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

    private func loadCategories() {
        viewModel.loadCategories()
    }

    private func loadHeader() {
        viewModel.loadHeader()
    }
}
