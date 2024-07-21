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

    var body: UIView {
        HelpCenterView(viewModel: viewModel.helpCenterViewModel)
    }

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
}

