//
//  UIView+Extensions.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 20/07/24.
//

import UIKit
import DeclarativeUIKit

private var tapGestureKey: UInt8 = 0

extension UIView {
    private class TapGestureHandler {
        let action: (() -> Void)

        init(action: @escaping (() -> Void)) {
            self.action = action
        }

        @objc func handleTap() {
            action()
        }
    }

    @discardableResult
    func onTapGesture(_ action: @escaping (() -> Void)) -> Self {
        isUserInteractionEnabled = true
        let handler = TapGestureHandler(action: action)
        let tapGesture = UITapGestureRecognizer(target: handler, action: #selector(handler.handleTap))

        addGestureRecognizer(tapGesture)

        objc_setAssociatedObject(self, &tapGestureKey, handler, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        return self
    }

    @discardableResult
    func isHidden(_ isHidden: Bool) -> Self {
        self.isHidden = isHidden
        return self
    }
    
    func show(_ viewController: UIViewController) {
        guard let parentViewController else { return }
        parentViewController.show(viewController, sender: self)
    }

    func show(_ view: UIView) {
        let viewController = UIViewController(nibName: nil, bundle: nil)
        viewController.view.add(view)
        show(viewController)
    }

    @discardableResult
    func bordered() -> Self {
        layer.cornerRadius = 5
        layer.masksToBounds = true
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1.0
        return self
    }
}
