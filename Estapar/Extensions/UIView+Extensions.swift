//
//  UIView+Extensions.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 20/07/24.
//

import UIKit
import DesignSystem
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

    func showErrorDialog(message: String) {
        guard let parentViewController else { return }
        parentViewController.showErrorDialog(message: message)
    }

    @discardableResult
    func bordered() -> Self {
        rounded()
        layer.borderColor = ColorScheme.gray100.uiColor.cgColor
        layer.borderWidth = 1.0
        return self
    }

    @discardableResult
    func rounded(_ cornerRadius: CGFloat = 10) -> Self {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        return self
    }

    @discardableResult
    func borderColor(_ color: UIColor, width: CGFloat = 1) -> Self {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        return self
    }

    @discardableResult
    func title(_ text: String) -> Self {
        DispatchQueue.main.async {
            self.parentViewController?.title = text
        }
        return self
    }

    @discardableResult
    func fadeIn(duration: TimeInterval = 0.5, completion: ((Bool) -> Void)? = nil) -> Self {
        self.alpha = 0 // Initially set the view's alpha to 0 (fully transparent)
        self.isHidden = false // Make sure the view is not hidden

        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1 // Animate the alpha to 1 (fully opaque)
        }, completion: completion)

        return self
    }

    @discardableResult
    func rotate90DegreesClockwise(animated: Bool = false, duration: TimeInterval = 0.3) -> Self {
        return rotate(to: .pi / 2, animated: animated, duration: duration)
    }

    @discardableResult
    func rotate90DegreesCounterclockwise(animated: Bool = false, duration: TimeInterval = 0.3) -> Self {
        return rotate(to: -.pi / 2, animated: animated, duration: duration)
    }

    @discardableResult
    func rotate180DegreesClockwise(animated: Bool = false, duration: TimeInterval = 0.3) -> Self {
        return rotate(to: .pi, animated: animated, duration: duration)
    }

    @discardableResult
    func rotate180DegreesCounterclockwise(animated: Bool = false, duration: TimeInterval = 0.3) -> Self {
        return rotate(to: -3.14159, animated: animated, duration: duration)
    }

    @discardableResult
    func rotate(to angle: CGFloat, animated: Bool = false, duration: TimeInterval = 0.3) -> Self {
        let rotation = {
            self.transform = self.transform.rotated(by: angle)
        }

        if animated {
            UIView.animate(withDuration: duration, animations: rotation)
        } else {
            rotation()
        }

        return self
    }
}
