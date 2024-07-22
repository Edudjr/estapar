//
//  HelpCenterView.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 19/07/24.
//

import Combine
import UIKit
import DeclarativeUIKit
import Kingfisher

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
            .header {
                HelpCenterWelcomeMessage(name: "Eduardo")
            }
            .headerBackground { [weak self] in
                if let image = self?.viewModel.headerBackgroundImage {
                    let url = URL(string: image)!
                    let imageView = UIImageView()
                        .contentMode(.scaleAspectFill)
                        .set(contentHuggingPriority: .defaultHigh, for: .vertical)
                        .set(compressionResistance: .defaultLow, for: .vertical)
                        .clipsToBounds(true)

                    imageView.kf.setImage(with: url)
                    return imageView
                } else {
                    return UIView()
                }
            }
            .asUIView()
            .backgroundColor(.white)
        }
    }

    init(viewModel: HelpCenterViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        add(body)
        bind()
        loadCategories()
        DispatchQueue.main.async {
            self.parentViewController?.title = "Central de ajuda"

        }
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
}
