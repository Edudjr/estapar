//
//  HomeViewController.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 18/07/24.
//

import UIKit
import DeclarativeUIKit

class HomeViewController: UIViewController {
    var body: UIView {
        ViewControllerHost {
            CollectionView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // add is a convenience method that abstracts the work of
        // setting `translatesAutoresizingMaskIntoConstraints` to false
        // and connecting the content view with the superview.
        // In other words, by calling `add` with `content`, it will expand the content to fit the view.
        view.add(body)
    }
}
