//
//  TextFieldView.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 21/07/24.
//

import DesignSystem
import DeclarativeUIKit
import UIKit

class TextFieldView: UIView, UITextFieldDelegate {

    var onEditHandler: ((String) -> Void)?

    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.borderStyle = .roundedRect

        // Add clear button.
        textField.clearButtonMode = .whileEditing
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        textField.backgroundColor = ColorScheme.gray100.uiColor
        textField.font = FontScheme.subtleSemiBold.uiFont
        textField.textColor = ColorScheme.primaryBlack.uiColor

        textField.addMagnifyingGlass()

        return textField
    }()

    init() {
        super.init(frame: .zero)
        add(textField)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @discardableResult
    func placeholder(_ text: String) -> Self {
        self.textField.placeholder = text
        return self
    }

    @discardableResult
    func text(_ text: String) -> Self {
        self.textField.text = text
        return self
    }

    @discardableResult
    func onEdit(_ handler: @escaping (String) -> Void) -> Self {
        onEditHandler = handler
        return self
    }

    @objc
    func textFieldDidChange() {
        onEditHandler?(textField.text ?? "")
    }

    func focus(_ shouldFocus: Bool = true) -> Self {
        if shouldFocus {
            if !textField.isFirstResponder {
                textField.becomeFirstResponder()
            }
        } else {
            textField.resignFirstResponder()
        }
        return self
    }

    // MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.rounded(8)
        textField.borderColor(ColorScheme.zulPrimary700.uiColor, width: 2)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        // Revert border color to gray when the text field loses focus
        textField.layer.borderColor = UIColor.clear.cgColor
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismiss the keyboard when the return key is pressed
        textField.resignFirstResponder()
        return true
    }
}
