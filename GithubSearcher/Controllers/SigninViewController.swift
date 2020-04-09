//
//  SigninViewController.swift
//  GithubSearcher
//
//  Created by praveen velanati on 4/9/20.
//  Copyright © 2020 praveen velanati. All rights reserved.
//

import UIKit
import AuthenticationServices

class SigninViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign In"
        stackView.distribution = .fillEqually
        stackView.spacing = 24
        configureSIWA()
        configureSkipButton()
    }
    
    func configureSIWA() {
        let button = ASAuthorizationAppleIDButton()
        button.frame.size = CGSize(width: 300, height: 50)
        button.center = self.view.center
        button.addTarget(self, action: #selector(signInWithApple), for: .touchUpInside)
        stackView.addArrangedSubview(button)
        
    }
    
    func configureSkipButton() {
        let button = UIButton()
        button.frame.size = CGSize(width: 300, height: 50)
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(navigateToMain), for: .touchUpInside)
        stackView.addArrangedSubview(button)
    }

    @objc func signInWithApple() {
        
        let signinRequest = ASAuthorizationAppleIDProvider().createRequest()
        signinRequest.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [signinRequest])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    @objc func navigateToMain() {
        guard let userSearchVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:  "UserSearchTableViewController") as? UserSearchTableViewController else {
            return
        }
        self.navigationController?.setViewControllers([userSearchVC], animated: false)
    }

}

extension SigninViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        #if targetEnvironment(simulator)
         navigateToMain()
        #endif
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        navigateToMain()
    }
    
}

extension SigninViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.windows.first ?? UIWindow()
    }
    
    
}
