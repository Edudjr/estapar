//
//  UITextField+Extensions.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 23/07/24.
//

import DesignSystem
import UIKit

extension UITextField {
    func addMagnifyingGlass() {
        // Add magnifying glass icon to the left view.
        let magnifyingGlassIcon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        magnifyingGlassIcon.tintColor = ColorScheme.zulPrimary700.uiColor
        magnifyingGlassIcon.contentMode = .scaleAspectFit
        magnifyingGlassIcon.frame = CGRect(x: 10, y: 0, width: 20, height: 20)

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        paddingView.addSubview(magnifyingGlassIcon)

        leftView = paddingView
        leftViewMode = .always
    }
}
