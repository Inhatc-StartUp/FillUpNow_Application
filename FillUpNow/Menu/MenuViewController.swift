//
//  MenuViewController.swift
//  FillUpNow
//
//  Created by 한소희 on 2023/03/25.
//

import UIKit
import Firebase

final class MenuViewController: UIViewController {
    
    @IBOutlet weak var userInfoButton: UIButton!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var signoutButton: UIButton!
    @IBOutlet weak var noticeButton: UIButton!
    @IBOutlet weak var pushAlarmSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInfoButton.layer.cornerRadius = 15
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let user = Auth.auth().currentUser {
            // 로그인 상태일 때 (유림)
            signinButton.isHidden = true
            signoutButton.isHidden = false
            userInfoButton.setTitle("\(user.email!)님의 회원정보입니다", for: .normal)
        } else {
            // 로그아웃 상태일 때 (유림)
            signinButton.isHidden = false
            signoutButton.isHidden = true
            userInfoButton.setTitle("로그인이 필요합니다.", for: .normal)
        }
    }
    
    @IBAction func pushAlarmSwitchTapped(_ sender: UISwitch) {
    }
    
    @IBAction func signinButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func signoutButtonTapped(_ sender: UIButton) {
        // 로그아웃 기능 구현(유림)
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            tabBarController?.selectedIndex = 1
        }catch let signOutError as NSError {
            print("Error: signout \(signOutError.localizedDescription)")
        }
    }
    
    @IBAction func userInfoButtonTapped(_ sender: UIButton) {
        // 로그인한 유저가 있는지에 따른 화면 전환(유림)
        if Auth.auth().currentUser != nil {
            let memberInformationViewController = storyboard?.instantiateViewController(withIdentifier: "MemberInformationViewController") as! MemberInformationViewController
            navigationController?.pushViewController(memberInformationViewController, animated: true)
        } else {
            let signinViewController = storyboard?.instantiateViewController(withIdentifier: "SigninViewController") as! SigninViewController
            navigationController?.pushViewController(signinViewController, animated: true)
        }
    }
}
