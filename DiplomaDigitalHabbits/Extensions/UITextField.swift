//
//  UITextField.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 21.11.2021.
//

import UIKit

extension UITextField {
//    func shake() {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: 320, height: 50))

        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
            target: nil,
            action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(
            title: "Done",
            style: UIBarButtonItem.Style.done,
            target: self,
            action: #selector(doneButtonTapped))
        doneToolbar.items = [flexSpace, done]
        doneToolbar.sizeToFit()
        self.inputAccessoryView = doneToolbar
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }

    @objc private func doneButtonTapped() {
        self.resignFirstResponder()
    }
    

}
