//
//  Created by Eduardo Domene Junior on 23/07/24.
//

import UIKit

public class DesignSystem {
    public static func configure() {
        loadFonts()
    }

    static func loadFonts() {
        let fontNames = [
            "Inter-Black",
            "Inter-Bold",
            "Inter-ExtraBold",
            "Inter-ExtraLight",
            "Inter-Light",
            "Inter-Medium",
            "Inter-Regular",
            "Inter-SemiBold",
            "Inter-Thin"
        ]

        for fontName in fontNames {
            guard let url = Bundle.module.url(forResource: fontName,
                                              withExtension: "ttf",
                                              subdirectory: ""),
                  let fontData = try? Data(contentsOf: url),
                  let provider = CGDataProvider(data: fontData as CFData),
                  let font = CGFont(provider) else {
                continue
            }

            var error: Unmanaged<CFError>?
            if !CTFontManagerRegisterGraphicsFont(font, &error) {
                let errorDescription = CFErrorCopyDescription(error?.takeUnretainedValue())
                print("Failed to register font: \(fontName), error: \(String(describing: errorDescription))")
            }
        }
    }
}
