//
//  MainTabBarController.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 26.10.2021.
//

import UIKit

class MainTabBarController: UITabBarController{
    var tradingCoordinator: TradingCoordinator?
    var cryptoCoordinator: CryptoCoordinator?
    var keyChain: KeyChainService
    
    init(keyChain: KeyChainService) {
        self.keyChain = keyChain
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearence()
        setupTabBarItems()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        guard let viewControllers = viewControllers else {return}

        let tradingVC = viewControllers[0]
        tradingVC.title = "Акции"

        let cryptoVC = viewControllers[1]
        cryptoVC.title = "Крипта"
        
    }

    func setupAppearence() {
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
        self.tabBar.tintColor = .white
        self.tabBar.backgroundColor = .black
    }

    func setupTabBarItems() {
        let tradingNavVC = UINavigationController()
        tradingCoordinator = TradingCoordinator(navigationController: tradingNavVC, keychain: keyChain)
        tradingNavVC.tabBarItem.title = "Акции"
        tradingCoordinator?.start()

        let cryptoNavController = UINavigationController()
        cryptoCoordinator = CryptoCoordinator(navigationController: cryptoNavController, keychain: keyChain)
        cryptoNavController.tabBarItem.title = "Крипта"
        cryptoCoordinator?.start()

        viewControllers = [tradingNavVC, cryptoNavController]
    }
}
