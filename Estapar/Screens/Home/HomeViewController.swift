//
//  HomeViewController.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 18/07/24.
//

import Combine
import UIKit
import DeclarativeUIKit

//class HomeViewController : UIViewController {
//
//    init(viewModel: HomeViewModel) {
////        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // 1.
//    lazy var stackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.spacing = 20
//        return stackView
//    }()
//
//    // 2.
//    lazy var scrollView: UIScrollView = {
//        let scrollView = ScrollView2 {
//            stackView
//        }
////        scrollView.addSubview(stackView)
////        scrollView.showsHorizontalScrollIndicator = false
//        return scrollView
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // 3.
//        view.add(scrollView)
//
//        // 4.
////        stackView.translatesAutoresizingMaskIntoConstraints = false
////        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
////        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
////        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
////        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
//
//        // 5.
//        for _ in 0..<20 {
//            let circle = UIView()
//            circle.translatesAutoresizingMaskIntoConstraints = true
//            circle.widthAnchor.constraint(equalToConstant: 50).isActive = true
//            circle.heightAnchor.constraint(equalToConstant: 50).isActive = true
//            circle.backgroundColor = .gray
//            circle.layer.cornerRadius = 24
//
//            stackView.addArrangedSubview(circle)
//        }
//    }
//}

final class HomeViewController: UIViewController {
    private let viewModel: HomeViewModel

    private var cardsCancellable: AnyCancellable?

    var body: UIView {
        if let cards = viewModel.cards {
            HelpCenterView(cards: cards)
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

