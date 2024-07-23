//
//  HelpCenterCategoryView.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 18/07/24.
//

import UIKit
import DeclarativeUIKit

class HelpCenterCategoryView: UIView {
    lazy var body: UIView = {
        VerticalStack {
            UILabel()
                .text(title)
                .font(.smallBold)
                .textColor(.primaryBlack)
                .numberOfLines(2)
                .padding(.bottom, 28)

            Spacer()

            HorizontalStack {
                UILabel()
                    .text("\(articlesNumber) artigos")
                    .font(.small)
                    .textColor(.gray400)

                ArrowView()
            }
            .alignment(.center)
        }
        .padding(.all, 10)
        .backgroundColor(.primaryWhite)
        .bordered()
    }()

    private let title: String
    private let articlesNumber: Int

    init(title: String, articlesNumber: Int) {
        self.title = title
        self.articlesNumber = articlesNumber
        super.init(frame: .zero)
        add(body)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// TODO: use view model in view
extension HelpCenterCategoryView {
    convenience init(viewModel: HelpCenterCategoryViewModel) {
        self.init(title: viewModel.title,
                  articlesNumber: viewModel.articlesNumber)
    }
}
