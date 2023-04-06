//
//  SigninViewController.swift
//  FillUpNow
//
//  Created by 한소희 on 2023/03/25.
//

import UIKit
import FirebaseAuth

final class SigninViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signinWithAppleButton: UIButton!
    @IBOutlet weak var signinWithGoogleButton: UIButton!
    @IBOutlet weak var signinWithGithubButton: UIButton!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func loginTappedButton(_ sender: UIButton) {
    }
    
    @IBAction func appleLoginTappedButton(_ sender: UIButton) {
    }
    
    @IBAction func googleLoginTappedButton(_ sender: UIButton) {
        
    
        
    }
    
    @IBAction func githubLoginTappedButton(_ sender: UIButton) {
    }
    
    
    @IBAction func signupTappedButton(_ sender: UIButton) {
    }
    
    
}
