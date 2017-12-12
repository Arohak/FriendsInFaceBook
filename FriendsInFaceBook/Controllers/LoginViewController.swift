//
//  ViewController.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 11/27/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: -
    // MARK: Properties
    
   // let loginView = LoginView()
    var hasToken = false
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.hasToken = FacebookSocialService.shared.alreadyLoggedIn()
        self.goToNextViewController()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.goToNextViewController()
    }
    
    // MARK: -
    // MARK: Private
    
    private func goToNextViewController(){
        if hasToken {
            let storyBoard : UIStoryboard = UIStoryboard(name: Constants.Main, bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: Constants.storyBoardIdentifier) as? UINavigationController
            nextViewController.do({self.present($0, animated:true, completion:nil)})
        }
    }
    func loginButtonPressed(){
        FacebookSocialService.shared.loginUser(complection:{
            print(Constants.successLogin)
            self.goToNextViewController()
        })
    }
}

