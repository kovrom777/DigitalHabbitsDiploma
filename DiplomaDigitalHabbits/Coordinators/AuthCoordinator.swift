//
//  AuthCoordinator.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 26.10.2021.
//

import UIKit

class AuthCoordinator: Coordinator{
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var keyChain: KeyChainService
    required init(navigationController: UINavigationController, keychain: KeyChainService) {
        self.navigationController = navigationController
        self.keyChain = keychain
    }

    func setMainScreen() {
        DispatchQueue.main.async {
            let scene = UIApplication.shared.connectedScenes.first
            if let sd: SceneDelegate = (scene?.delegate as? SceneDelegate){
                let tabBarVc = MainTabBarController(keyChain: self.keyChain)
                sd.window?.rootViewController = tabBarVc
            }
        }
    }
    
    func start() {
        DispatchQueue.main.async {
            self.navigationController.isNavigationBarHidden = true
            let signInVC = SignInViewController()
            signInVC.coordinator = self
            self.navigationController.pushViewController(signInVC, animated: true)
        }
    }
}
