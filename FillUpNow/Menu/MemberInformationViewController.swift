//
//  MemberInformationViewController.swift
//  FillUpNow
//
//  Created by 한소희 on 2023/04/05.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

final class MemberInformationViewController: UIViewController {
    
    var userdto: userDTO?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordEditTextField: UITextField!
    @IBOutlet weak var oilSegmentedControl: UISegmentedControl!
    @IBOutlet weak var locationSegmentedControl: UISegmentedControl!
    @IBOutlet weak var selfSegmentedControl: UISegmentedControl!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let ref = Database.database().reference().child("users").child(uid)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let userDict = snapshot.value as? [String: Any] {
                // 파이어베이스에서 가져온 값을 userdto 객체에 할당
                self.userdto = userDTO(
                    nickname: userDict["nickname"] as? String ?? "",
                    choiceOil: userDict["choiceOil"] as? String ?? "",
                    choiceGasStation: userDict["choiceGasStation"] as? String ?? "",
                    choiceSelf: userDict["choiceSelf"] as? String ?? ""
                )
                
                // 업데이트 된 userdto 객체의 프로퍼티들을 UI에 반영
                self.nameTextField.text = self.userdto?.nickname
                
                if self.userdto?.choiceOil == "경유" {
                    self.oilSegmentedControl.selectedSegmentIndex = 0
                } else if self.userdto?.choiceOil == "휘발유" {
                    self.oilSegmentedControl.selectedSegmentIndex = 1
                }else {
                    self.oilSegmentedControl.selectedSegmentIndex = 2
                }
                
                if self.userdto?.choiceGasStation == "가까운 곳" {
                    self.locationSegmentedControl.selectedSegmentIndex = 0
                }
                else {
                    self.locationSegmentedControl.selectedSegmentIndex = 1
                }
                
                if self.userdto?.choiceSelf == "셀프 O" {
                    self.selfSegmentedControl.selectedSegmentIndex = 0
                }else {
                    self.selfSegmentedControl.selectedSegmentIndex = 1
                }
            }
        }) { (error) in
            print("Error: \(error.localizedDescription)")
        }
        [nameTextField, oilSegmentedControl, locationSegmentedControl, selfSegmentedControl, saveButton, cancelButton, passwordEditTextField].forEach {
            $0?.isEnabled = false
        }
    }

    
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        [nameTextField, oilSegmentedControl, locationSegmentedControl, selfSegmentedControl, saveButton, cancelButton, passwordEditTextField].forEach {
            $0?.isEnabled = true
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        guard let nickname = nameTextField.text else {
            return
        }
        userdto?.nickname = nickname
        print(nickname)
        
        
        let selectedSegmentIndex1 = oilSegmentedControl.selectedSegmentIndex
        guard let selectedSegmentText1 = oilSegmentedControl.titleForSegment(at: selectedSegmentIndex1) else {
            showAlert(withTitle: "알림", message: "선택된 오일이 없습니다.")
            return
        }
        userdto?.choiceOil = selectedSegmentText1
        print(selectedSegmentText1)
        
        let selectedSegmentIndex2 = locationSegmentedControl.selectedSegmentIndex
        guard let selectedSegmentText2 = locationSegmentedControl.titleForSegment(at: selectedSegmentIndex2) else {
            showAlert(withTitle: "알림", message: "선택된 장소가 없습니다.")
            return
        }
        userdto?.choiceGasStation = selectedSegmentText2
        print(selectedSegmentText2)
        
        let selectedSegmentIndex3 = selfSegmentedControl.selectedSegmentIndex
        guard let selectedSegmentText3 = selfSegmentedControl.titleForSegment(at: selectedSegmentIndex3) else {
            showAlert(withTitle: "알림", message: "선택된 셀프유무가 없습니다.")
            return
        }
        userdto?.choiceSelf = selectedSegmentText3
        print(selectedSegmentText3)
        
        // 현재 사용자의 uid 가져오기
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        // "users" 노드의 하위 노드로 현재 사용자의 uid를 가진 노드 생성
        let userRef = Database.database().reference().child("users").child(uid)
        
        // 기존 데이터를 읽어온 후, 수정할 값을 적용
        userRef.observeSingleEvent(of: .value) { [self] (snapshot) in
            // 수정된 데이터를 저장
            userRef.updateChildValues(["nickname": self.userdto?.nickname ?? self.nameTextField.text as Any, "choiceOil": self.userdto?.choiceOil ?? selectedSegmentText1, "choiceGasStation": self.userdto?.choiceGasStation ?? selectedSegmentText2, "choiceSelf": self.userdto?.choiceSelf ?? selectedSegmentText3]) { (error, ref) in
                if let error = error {
                    print("Error updating child values: \(error.localizedDescription)")
                } else {
                    print("Child values updated successfully")
                    self.showAlert(withTitle: "알림", message: "정보가 저장되었습니다..")
                }
            }
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func withdrawalButtonTapped(_ sender: UIButton) {
        // 현재 로그인한 사용자의 UID 가져오기
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        let uid = currentUser.uid
        
        // 데이터베이스에서 사용자 데이터 삭제
        Database.database().reference().child("users").child(uid).removeValue { error, _ in
            if let error = error {
                print("Error deleting data: \(error.localizedDescription)")
                return
            }
            print("Data successfully deleted.")
            self.showAlert(withTitle: "알림", message: "성공적으로 회원탈퇴 되었습니다.")
        }
        
        // Firebase Authentication에서 사용자 삭제
        currentUser.delete { error in
            if let error = error {
                print("Error deleting user: \(error.localizedDescription)")
                return
            }
            print("회원탈퇴가 되었습니다.")
            self.showHomeViewController()
        }
    }
}

extension MemberInformationViewController {
    
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
