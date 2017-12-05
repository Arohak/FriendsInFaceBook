//
//  ViewController.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 11/27/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

//    @IBOutlet weak var loginButton: UIButton?
//    @IBOutlet weak var welcomeLabel: UILabel?
    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if FacebookSocialService.shared.alreadyLoggedIn() == true {
         //  self.login
//            self.loginButton?.isHidden = true
//            self.welcomeLabel?.isHidden = true
            self.goToNextViewController()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if FacebookSocialService.shared.alreadyLoggedIn() == true {
           self.goToNextViewController()
        }
    }
    @IBAction func loginButtonPressed(_ sender: Any) {
        FacebookSocialService.shared.loginUser()
    }
    func goToNextViewController(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GoToSeeFriends") as! UINavigationController
        self.present(nextViewController, animated:true, completion:nil)
    }

    

}

