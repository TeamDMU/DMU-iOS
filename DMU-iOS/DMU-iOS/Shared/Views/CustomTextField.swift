//
//  CustomTextField.swift
//  DMU-iOS
//
//  Created by 이예빈 on 2/9/24.
//

import SwiftUI

struct CustomTextField: UIViewRepresentable {
    @Binding var text: String
    var isFirstResponder: Bool = false
    var placeholder: String = ""
    var onCommit: (() -> Void)? = nil
    var textColor: UIColor = .black

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.returnKeyType = .done
        textField.placeholder = placeholder
        textField.textColor = textColor
        textField.delegate = context.coordinator
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        if isFirstResponder {
            uiView.becomeFirstResponder()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: CustomTextField

        init(_ textField: CustomTextField) {
            self.parent = textField
        }

        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let currentText = textField.text,
               let textRange = Range(range, in: currentText) {
                let updatedText = currentText.replacingCharacters(in: textRange, with: string)
                parent.text = updatedText
            }
            return true
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            parent.onCommit?()
            return true
        }
    }
}
