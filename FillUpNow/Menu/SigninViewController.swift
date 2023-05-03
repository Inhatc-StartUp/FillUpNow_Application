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
        
        [signinWithAppleButton, signinWithGoogleButton, signinWithGithubButton].forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.gray.cgColor
            $0?.layer.cornerRadius = 10
        }
        
    }
    //로그인 버튼을 눌렀을 경우(유림)
    @IBAction func loginTappedButton(_ sender: UIButton) {
        
        guard let email = emailTextField.text else {
            showAlert(withTitle: "알림", message: "이메일을 입력해주세요.")
            return
        }
        
        guard let password = passwordTextField.text else {
            showAlert(withTitle: "알림", message: "비밀번호를 입력해주세요.")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) {[weak self] _, error in
            guard let self = self else { return }
            
            if let error = error {
                self.showAlert(withTitle: "Error", message: error.localizedDescription)
            }else {
                self.showHomeViewController()
            }
        }
    }
    @IBAction func signupTappedButton(_ sender: UIButton) {
    }
    
    @IBAction func appleLoginTappedButton(_ sender: UIButton) {
    }
    
    @IBAction func googleLoginTappedButton(_ sender: UIButton) {
        
    
        
    }
    
    @IBAction func githubLoginTappedButton(_ sender: UIButton) {
    }
    
    //홈 버튼으로 가는 함수(유림)
    private func showHomeViewController() {
        if let tabBarController = self.tabBarController {
            tabBarController.selectedIndex = 1
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    //에러 메세지 알림 출력(유림)
    private func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
