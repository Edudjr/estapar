//
//  UINavigationController+Extensions.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 22/07/24.
//

import DeclarativeUIKit
import UIKit

extension UINavigationController {
    @discardableResult
    func setDefaultAppearance() -> Self {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()
        navigationBarAppearance.backgroundColor = ColorScheme.zulPrimary700.uiColor
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.font: FontScheme.smallBold.uiFont,
            NSAttributedString.Key.foregroundColor: ColorScheme.primaryWhite.uiColor
        ]
        navigationBar.standardAppearance = navigationBarAppearance
        navigationBar.compactAppearance = navigationBarAppearance
        navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationBar.tintColor = ColorScheme.primaryWhite.uiColor
        self.view.backgroundColor(.primaryWhite)
        return self
    }

    convenience init(rootView: UIView) {
        let viewController = UIViewController()
        viewController.view.add(rootView)
        self.init(rootViewController: viewController)
    }
}
