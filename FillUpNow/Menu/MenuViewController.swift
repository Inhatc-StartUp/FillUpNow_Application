//
//  MenuViewController.swift
//  FillUpNow
//
//  Created by 한소희 on 2023/03/25.
//

import UIKit

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
        signoutButton.isHidden = true
    }
    
    @IBAction func pushAlarmSwitchTapped(_ sender: UISwitch) {
    }
    
    @IBAction func signinButtonTapped(_ sender: UIButton) {
    }
    
    
    @IBAction func signoutButtonTapped(_ sender: UIButton) {
    }
    

}
