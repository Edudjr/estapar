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
        navigationBarAppearance.backgroundColor = .blue
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationBar.standardAppearance = navigationBarAppearance
        navigationBar.compactAppearance = navigationBarAppearance
        navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationBar.tintColor = .white
        self.view.backgroundColor(.white)
        return self
    }

    convenience init(rootView: UIView) {
        let viewController = UIViewController()
        viewController.view.add(rootView)
        self.init(rootViewController: viewController)
    }
}
