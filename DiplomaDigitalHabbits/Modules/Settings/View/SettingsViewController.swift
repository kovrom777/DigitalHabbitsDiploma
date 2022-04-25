//
//  SettingsViewController.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 22.11.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Variables
    let contentView = SettingsView()
    weak var coordinator: TradingCoordinator?

    // MARK: - ViewController lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.switchElem.addTarget(self, action: #selector(turnWebSocketOn), for: .touchUpInside)
    }

    override func loadView() {
        view = contentView
    }
    
    // MARK: - Private methods
    
    @objc private func turnWebSocketOn() {
        SettingsModel.shared.useWebSocket.toggle()
        print(SettingsModel.shared.useWebSocket)
    }

}
