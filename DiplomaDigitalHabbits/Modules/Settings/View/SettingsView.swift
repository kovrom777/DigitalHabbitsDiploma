//
//  SettingsView.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 22.11.2021.
//

import UIKit

class SettingsView: UIView {

    // MARK: - Variables
    let shouldUseWebSocketLabel = UILabel()
    let switchElem = UISwitch()
    let exitButton = UIButton()
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        shouldUseWebSocketLabel.text = "Включить WebSocket?"
        shouldUseWebSocketLabel.textColor = .black
        shouldUseWebSocketLabel.textAlignment = .left
        shouldUseWebSocketLabel.font = UIFont.boldSystemFont(ofSize: 20)
        shouldUseWebSocketLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(shouldUseWebSocketLabel)
        
        switchElem.setOn(false, animated: true)
        switchElem.translatesAutoresizingMaskIntoConstraints = false
        addSubview(switchElem)

        exitButton.setTitle("Выйти", for: .normal)
        exitButton.setTitleColor(.red, for: .normal)
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(exitButton)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods
    private func setupConstraints() {
        switchElem.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        switchElem.heightAnchor.constraint(equalToConstant: 50).isActive = true
        switchElem.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        switchElem.widthAnchor.constraint(equalToConstant: 60).isActive = true

        shouldUseWebSocketLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        shouldUseWebSocketLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        shouldUseWebSocketLabel.trailingAnchor.constraint(equalTo: switchElem.leadingAnchor).isActive = true
        shouldUseWebSocketLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true

        exitButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        exitButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        exitButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        exitButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
