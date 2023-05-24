//
//  MenuViewController.swift
//  FillUpNow
//
//  Created by 한소희 on 2023/03/25.
//

import UIKit
import Firebase
import UserNotifications

final class MenuViewController: UIViewController {
    // 소희
    var isOn: Bool!
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    @IBOutlet weak var userInfoButton: UIButton!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var signoutButton: UIButton!
    @IBOutlet weak var FAQButton: UIButton!
    @IBOutlet weak var pushAlarmSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInfoButton.layer.cornerRadius = 15
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 소희
        pushAlarmSwitch.isOn = UserDefaults.standard.bool(forKey: "pushAlarmSwitchStatus")
        
        UNUserNotificationCenter.current().getNotificationSettings {
            settings in
            if settings.authorizationStatus == .authorized {
                DispatchQueue.main.async {
                    self.pushAlarmSwitch.isOn = true
                    UserDefaults.standard.set(self.pushAlarmSwitch.isOn, forKey: "pushAlarmSwitchStatus")
                }
            } else {
                DispatchQueue.main.async {
                    self.pushAlarmSwitch.isOn = false
                    UserDefaults.standard.set(self.pushAlarmSwitch.isOn, forKey: "pushAlarmSwitchStatus")
                }
            }
        }
        
        if let user = Auth.auth().currentUser {
            // 로그인 상태일 때 (유림)
            signinButton.isHidden = true
            signoutButton.isHidden = false
            let uid = user.uid
            let ref = Database.database().reference().child("users/\(uid)")
            ref.observeSingleEvent(of: .value) { snapshot in
                if let userData = snapshot.value as? [String: Any] {
                    if let nickname = userData["nickname"] as? String, !nickname.isEmpty {
                        DispatchQueue.main.async {
                            self.userInfoButton.setTitle("\(nickname)님의 회원정보입니다", for: .normal)
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.userInfoButton.setTitle("닉네임을 입력해주세요", for: .normal)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.userInfoButton.setTitle("회원정보를 입력해주세요", for: .normal)
                    }
                }
            }
        } else {
            // 로그아웃 상태일 때 (유림)
            signinButton.isHidden = false
            signoutButton.isHidden = true
            userInfoButton.setTitle("로그인이 필요합니다.", for: .normal)
        }
    }
    
    // 소희
    private func changeAlarmPermission() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func pushAlarmSwitchTapped(_ sender: UISwitch) {
        // 소희
        if pushAlarmSwitch.isOn {
            changeAlarmPermission()
            UserDefaults.standard.set(pushAlarmSwitch.isOn, forKey: "pushAlarmSwitchStatus")
        } else {
            changeAlarmPermission()
            UserDefaults.standard.set(pushAlarmSwitch.isOn, forKey: "pushAlarmSwitchStatus")
        }
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
