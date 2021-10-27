//
//  TradingCoordinator.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 26.10.2021.
//

import UIKit

class TradingCoordinator: Coordinator{
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        DispatchQueue.main.async {
            self.navigationController.isNavigationBarHidden = false
            let tradingVc = TradingViewController()
            tradingVc.coordinator = self
            self.navigationController.pushViewController(tradingVc, animated: true)
        }
    }
    
    
}
