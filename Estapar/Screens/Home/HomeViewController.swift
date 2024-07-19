//
//  HomeViewController.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 18/07/24.
//

import Combine
import UIKit
import DeclarativeUIKit

final class HomeViewController: UIViewController {
    private let viewModel: HomeViewModel

    private var cardsCancellable: AnyCancellable?

    var body: UIView {
        if let cards = viewModel.cards {
            ViewControllerHost {
                CollectionView(cards) { card in
                    HelpCenterCard(title: card.title,
                                   articlesNumber: card.articlesNumber)
                }
            }
        } else {
            LoadingView()
        }
    }

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        reloadView()
        bindCards()
        loadCards()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.add(body).backgroundColor(.white)
    }

    private func reloadView() {
        view.subviews.forEach { $0.removeFromSuperview() }
        view.add(body)
    }

    private func bindCards() {
        cardsCancellable = viewModel.$cards
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.reloadView()
            }
    }

    private func loadCards() {
        viewModel.loadCards()
    }
}

