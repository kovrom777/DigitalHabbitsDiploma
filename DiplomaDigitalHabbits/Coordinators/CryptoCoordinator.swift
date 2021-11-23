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
    
    func presentAddNewRecord (viewController: CryptoViewController, isStock: Bool) {
        let recordVc = AddNewRecordViewController(isStock: isStock)
        recordVc.delegate = viewController
        viewController.present(recordVc, animated: true, completion: nil)
    }

    func presentSettingsScreen() {
        let viewController = SettingsViewController()
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func start() {
        DispatchQueue.main.async {
            self.navigationController.isNavigationBarHidden = false
            let service = URLSessionManager()
            let cryptoVC = CryptoViewController(service: service)
            cryptoVC.coordinator = self
            self.navigationController.pushViewController(cryptoVC, animated: true)
        }
    }
}
