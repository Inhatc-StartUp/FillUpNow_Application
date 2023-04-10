//
//  NoticeViewController.swift
//  FillUpNow
//
//  Created by 한소희 on 2023/03/25.
//

import UIKit

final class FAQViewController: UIViewController {

    // 소희 여기부터 !!!!
    @IBOutlet weak var A1Label: UILabel!
    @IBOutlet weak var A2Label: UILabel!
    @IBOutlet weak var A3Label: UILabel!
    @IBOutlet weak var A4Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        [A1Label,A2Label, A3Label, A4Label].forEach {
            $0?.isHidden = true
        }
    }
    
    @IBAction func Q1ButtonTapped(_ sender: UIButton) {
        A1Label.isHidden = false
        [A2Label, A3Label, A4Label].forEach {
            $0?.isHidden = true
        }
    }
    
    @IBAction func Q2ButtonTapped(_ sender: UIButton) {
        A2Label.isHidden = false
        [A1Label, A3Label, A4Label].forEach {
            $0?.isHidden = true
        }
    }
    
    @IBAction func Q3ButtonTapped(_ sender: UIButton) {
        A3Label.isHidden = false
        [A1Label, A2Label, A4Label].forEach {
            $0?.isHidden = true
        }
    }
    
    @IBAction func Q4ButtonTapped(_ sender: UIButton) {
        A4Label.isHidden = false
        [A1Label, A2Label, A3Label].forEach {
            $0?.isHidden = true
        }
    }
    // 여기까즹
}
