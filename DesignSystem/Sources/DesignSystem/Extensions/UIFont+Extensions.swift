//
//  UIFont+Extensions.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 23/07/24.
//

import UIKit

public extension UIFont {
    static func interFont(ofSize size: CGFloat, weightValue: Int) -> UIFont? {
        let fontName: String

        switch weightValue {
        case 100:
            fontName = "Inter-Thin"
        case 200:
            fontName = "Inter-ExtraLight"
        case 300:
            fontName = "Inter-Light"
        case 400:
            fontName = "Inter-Regular"
        case 500:
            fontName = "Inter-Medium"
        case 600:
            fontName = "Inter-SemiBold"
        case 700:
            fontName = "Inter-Bold"
        case 800:
            fontName = "Inter-ExtraBold"
        case 900:
            fontName = "Inter-Black"
        default:
            fontName = "Inter-Regular" // Default to Regular if weight is unknown
        }

        return UIFont(name: fontName, size: size)
    }
}
