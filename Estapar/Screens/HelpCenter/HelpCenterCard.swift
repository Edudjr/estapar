//
//  HelpCenterCard.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 18/07/24.
//

import UIKit
import DeclarativeUIKit

class HelpCenterCard: UIView {
    lazy var body: UIView = {
        VerticalStack {
            UILabel()
                .text(title)
                .font(.boldSystemFont(ofSize: 18))
                .numberOfLines(2)
                .padding(.bottom, 28)

            Spacer()

            HorizontalStack {
                UILabel()
                    .text("\(articlesNumber) artigos")
                    .font(.systemFont(ofSize: 12))

                UIImageView(image: UIImage(systemName: "arrow.right"))
                    .contentMode(.scaleAspectFit)
                    .set(contentHuggingPriority: .defaultHigh, for: .horizontal)
                    .padding(.leading, 20)
            }
            .alignment(.top)
            .padding(.leading, 10)
        }
        .backgroundColor(.white)
        .dropShadow()
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
