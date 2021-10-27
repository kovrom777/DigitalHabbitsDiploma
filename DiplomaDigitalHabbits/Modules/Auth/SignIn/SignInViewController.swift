//
//  SignInViewController.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 26.10.2021.
//

import UIKit

class SignInViewController: UIViewController {

    weak var coordinator: AuthCoordinator?
    let contentView = SignInView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        contentView.continueButton.addTarget(self, action: #selector(goToMainScreen), for: .touchUpInside)
    }
    
    @objc func goToMainScreen(){
        coordinator?.setMainScreen()
    }
    
    override func loadView() {
        view = contentView
    }
}
