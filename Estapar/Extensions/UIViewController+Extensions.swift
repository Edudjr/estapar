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
}
