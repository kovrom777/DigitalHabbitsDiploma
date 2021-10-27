//
//  SignInView.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 26.10.2021.
//

import UIKit

class SignInView: UIView {
    
    let loginTextField = UITextField()
    let passTextField = UITextField()
    let continueButton = UIButton()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        loginTextField.attributedPlaceholder = NSAttributedString(string: "Login",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        loginTextField.layer.cornerRadius = 16
        loginTextField.layer.borderWidth = 1
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loginTextField)
        
        passTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        passTextField.layer.cornerRadius = 16
        passTextField.layer.borderWidth = 1
        passTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(passTextField)
        
        continueButton.backgroundColor = .black
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.setTitle("Sign In", for: .normal)
        continueButton.layer.cornerRadius = 16
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(continueButton)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        loginTextField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50).isActive = true
        loginTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        loginTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        loginTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        passTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 12).isActive = true
        passTextField.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor).isActive = true
        passTextField.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor).isActive = true
        passTextField.heightAnchor.constraint(equalTo: loginTextField.heightAnchor).isActive = true
        
        continueButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        continueButton.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor).isActive = true
        continueButton.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }

}
