//
//  File.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 19/07/24.
//

import UIKit
import DeclarativeUIKit

extension UIViewController {
    func asUIView() -> UIView {
        ViewControllerHost {
            self
        }
    }

    func show(_ view: UIView) {
        let viewController = UIViewController(nibName: nil, bundle: nil)
        viewController.view.add(view)
        show(viewController, sender: self)
    }

    func showErrorDialog(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
