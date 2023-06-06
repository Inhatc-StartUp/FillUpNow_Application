//
//  SigninViewController.swift
//  FillUpNow
//
//  Created by 한소희 on 2023/03/25.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import AuthenticationServices
import CryptoKit

final class SigninViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signinWithAppleButton: UIButton!
    @IBOutlet weak var signinWithGoogleButton: GIDSignInButton!
    @IBOutlet weak var signinWithGithubButton: UIButton!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    private var currentNonce: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        [signinWithAppleButton, signinWithGoogleButton, signinWithGithubButton].forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.gray.cgColor
            $0?.layer.cornerRadius = 10
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
    // 애플 로그인(주훈)
    @IBAction func appleLoginTappedButton(_ sender: UIButton) {
        startSignInWithAppleFlow()
    }
    
    // 구글 로그인(주훈)
    @IBAction func googleLoginTappedButton(_ sender: UIButton) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] result, error in
            
            guard error == nil else {return}
            guard let user = result?.user, let idToken = user.idToken?.tokenString else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) {[weak self] _, error in
                guard let self = self else { return }
                
                if let error = error {
                    self.showAlert(withTitle: "Error", message: error.localizedDescription)
                }else {
                    self.showHomeViewController()
                }
            }
        }
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

extension SigninViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print ("Error Apple sign in: %@", error)
                    return
                }
                self.showHomeViewController()
            }
        }
    }
}

//애플로그인 (주훈)
extension SigninViewController {
    func startSignInWithAppleFlow() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }
}

extension SigninViewController : ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
