//
//  SignInViewController.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 26.10.2021.
//

import UIKit

class SignInViewController: UIViewController {

    //MARK: - variables
    weak var coordinator: AuthCoordinator?
    let contentView = SignInView()
    let fileManager = FileManagerInteractor()
    let shouldValidateLogin = false
    var userModel: UserModel?
    
    // MARK: - View Controller lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.continueButton.addTarget(self, action: #selector(goToMainScreen), for: .touchUpInside)
        userModel = fileManager.readFile()
    }

    override func loadView() {
        view = contentView
    }

    // MARK: - Private Methods

    @objc func goToMainScreen() {
        if shouldValidateLogin {
            if let login = contentView.loginTextField.text, login == userModel?.login ?? "" {
                if let pass = contentView.passTextField.text, pass == userModel?.password ?? "" {
                    coordinator?.setMainScreen()
                } else {
                    contentView.passTextField.shake()
                }
            } else {
                contentView.loginTextField.shake()
            }
        } else {
            coordinator?.setMainScreen()
        }
    }
}
