//
//  MemberInformationViewController.swift
//  FillUpNow
//
//  Created by 한소희 on 2023/04/05.
//

import UIKit

final class MemberInformationViewController: UIViewController {
    
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
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func withdrawalButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func oilSegmentedControlTapped(_ sender: UISegmentedControl) {
    }
    
    @IBAction func locationSegmentedControlTapped(_ sender: UISegmentedControl) {
    }
    
    @IBAction func selfSegmentedControlTapped(_ sender: UISegmentedControl) {
    }
}
