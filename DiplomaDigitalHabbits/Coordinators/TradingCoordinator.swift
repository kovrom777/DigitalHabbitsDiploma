//
//  TradingCoordinator.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 26.10.2021.
//

import UIKit

class TradingCoordinator: Coordinator {
    var keyChain: KeyChainService
    
    required init(navigationController: UINavigationController, keychain: KeyChainService) {
        self.navigationController = navigationController
        self.keyChain = keychain
    }
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    func presentAddNewRecord (viewController: TradingViewController, isStock: Bool) {
        let recordVc = AddNewRecordViewController(isStock: isStock)
        recordVc.delegate = viewController
        viewController.present(recordVc, animated: true, completion: nil)
    }

    func presentSettingsScreen() {
        let viewController = SettingsViewController()
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func showCharts(viewcontroller: UIViewController, dataSet: [CGFloat], title: String) {
        let vc = ChartsViewController(dataSet: dataSet, title: title)
//        viewcontroller.present(vc, animated: true, completion: nil)
        self.navigationController.pushViewController(vc, animated: true)
    }

    func start() {
        self.navigationController.isNavigationBarHidden = false
        let service = URLSessionManager()
        let tradingVc = TradingViewController(service: service)
        tradingVc.coordinator = self
        self.navigationController.pushViewController(tradingVc, animated: true)
    }
}
