//
//  TextFieldView.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 21/07/24.
//

import UIKit

class TextFieldView: UIView, UITextFieldDelegate {

    var onEditHandler: ((String) -> Void)?

    lazy var textField: UITextField = {
        // Create a UITextField.
        let textField = UITextField()

        // Set Delegate to itself
        textField.delegate = self

        // Display frame.
        textField.borderStyle = .roundedRect

        // Add clear button.
        textField.clearButtonMode = .whileEditing

        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

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

    func focus() -> Self {
        textField.becomeFirstResponder()
        return self
    }
}

final class PublishedExtractor<T> {
    @Published var value: T

    init(_ wrapper: Published<T>) {
        _value = wrapper
    }
}
