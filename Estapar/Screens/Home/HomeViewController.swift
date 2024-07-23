//
//  HomeViewController.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 18/07/24.
//

import Combine
import UIKit
import DeclarativeUIKit
import DesignSystem

/**
 Initial view controller for our App.
 */
final class HomeViewController: UIViewController {
    private let viewModel: HomeViewModel
    private var cancellables = Set<AnyCancellable>()

    var body: UIView {
        VerticalStack {
            Spacer()

            UILabel()
                .text("Abrir central de ajuda")
                .font(.subtleSemiBold)
                .textColor(.zulPrimary700)
                .textAlignment(.center)
                .padding(.all, 8)
                .bordered()
                .onTapGesture { [weak self] in
                    self?.viewModel.openHelpCenterTap()
                }

            Spacer()
        }
        .padding(.all, 16)
    }

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.add(body).backgroundColor(.primaryWhite)
    }

    private func reloadView() {
        view.subviews.forEach { $0.removeFromSuperview() }
        view.add(body)
    }

    private func bind() {
        viewModel.$navigateToHelpCenterView
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] viewModel in
                let view = HelpCenterView(viewModel: viewModel)
                let navigation = UINavigationController(rootView: view).setDefaultAppearance()

                self?.show(navigation, sender: nil)
            }
            .store(in: &cancellables)
    }
}

