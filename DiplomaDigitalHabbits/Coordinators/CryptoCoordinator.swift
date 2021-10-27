//
//  CryptoCoordinator.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 26.10.2021.
//

import UIKit

class CryptoCoordinator: Coordinator{
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        DispatchQueue.main.async {
            self.navigationController.isNavigationBarHidden = false
            let cryptoVC = CryptoViewController()
            cryptoVC.coordinator = self
            self.navigationController.pushViewController(cryptoVC, animated: true)
        }
    }
    
    
}
