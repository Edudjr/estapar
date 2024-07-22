//
//  Header.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 22/07/24.
//

import UIKit

struct Header {
    let line1: String?
    let line2: String?
    var image: String? {
        let scale = Int(UIScreen.main.scale)
        switch scale {
        case 1:
            return image1x
        case 2:
            return image2x
        default:
            return image3x
        }
    }
    private let image1x: String?
    private let image2x: String?
    private let image3x: String?

    init(_ header: HeaderDTO) {
        self.line1 = header.line1?.replacingOccurrences(of: "%firstName%", with: "Eduardo")
        self.line2 = header.line2
        self.image1x = header.image?.oneX
        self.image2x = header.image?.twoX
        self.image3x = header.image?.threeX
    }
}
