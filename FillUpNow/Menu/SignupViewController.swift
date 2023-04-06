//
//  signupViewController.swift
//  FillUpNow
//
//  Created by 한소희 on 2023/04/05.
//

import UIKit
import FirebaseAuth

final class SignupViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    @IBOutlet weak var emailAuthButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        self.view.frame.origin.y = 0 - keyboardSize.height
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == passwordCheckTextField {
            let screenHeight = UIScreen.main.bounds.height
            let keyboardHeight: CGFloat = 300
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = -(keyboardHeight - (screenHeight - self.signupButton.frame.maxY))
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func emailAuthTappedButton(_ sender: UIButton) {
    }
    
    
    @IBAction func signupTappedButton(_ sender: UIButton) {
        // 변수 선언(유림)
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let passwordCheck = passwordCheckTextField.text ?? ""
        
        // 이메일을 입력하지 않은 경우(유림)
        if email.isEmpty {
            showAlert(withTitle: "Error", message: "이메일을 입력해주세요.")
            return
        }
        
        // 비밀번호를 입력하지 않은 경우(유림)
        if password.isEmpty {
            showAlert(withTitle: "Error", message: "비밀번호를 입력해주세요.")
            return
        }
        
        // 비밀번호 확인을 입력하지 않은 경우(유림)
        if passwordCheck.isEmpty {
            showAlert(withTitle: "Error", message: "비밀번호 확인을 입력해주세요")
            return
        }
        
        // 비밀번호랑 비밀번호 확인이 다른 경우(유림)
        if password != passwordCheck{
            showAlert(withTitle: "Error", message: "비밀번호가 일치하지 않습니다.")
            return
        }
        
        // 신규 사용자 생성(주훈)
        Auth.auth().createUser(withEmail: email, password: password) {[weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                showAlert(withTitle: "Error", message: error.localizedDescription)
            } else {
                // 버튼 눌렀을 때 이동하게 만들기
                joinAlert(withTitle: "성공", message: "회원가입에 성공하셨습니다.", email: email, password: password)
            }
        }
    }
    
    // 뷰
    private func showHomeViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = tabBarController
            self.view.window?.rootViewController = window.rootViewController
            self.view.window?.makeKeyAndVisible()
        }
    }

    // 회원가입 메세지 알림 출력(주훈)
    func joinAlert(withTitle title: String, message: String, email: String, password: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            self.loginUser(email: email, password: password)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    // 에러 메세지 알림 출력(유림)
    func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    // 로그인 함수 (주훈)
    private func loginUser(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) {[weak self] _, error in
            guard let self = self else { return }
            if let error = error {
                showAlert(withTitle: "Error", message: error.localizedDescription)
            }else {
                showHomeViewController()
            }
        }
    }

}
