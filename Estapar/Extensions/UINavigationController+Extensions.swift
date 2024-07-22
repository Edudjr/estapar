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
        navigationBarAppearance.backgroundColor = .blue
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationBar.compactAppearance = navigationBarAppearance
        self.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        self.view.backgroundColor(.white)
        return self
    }

    convenience init(rootView: UIView) {
        let viewController = UIViewController()
        viewController.view.add(rootView)
        self.init(rootViewController: viewController)
    }
}
