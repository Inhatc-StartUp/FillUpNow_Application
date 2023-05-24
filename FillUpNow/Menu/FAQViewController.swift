//
//  NoticeViewController.swift
//  FillUpNow
//
//  Created by 한소희 on 2023/03/25.
//

import UIKit

final class FAQViewController: UIViewController {
    
    // 소희 여기부터 !!!
    @IBOutlet weak var NicknameAnswerLabel: UILabel!
    @IBOutlet weak var FindGasStationAnswerLabel: UILabel!
    @IBOutlet weak var InformationErrorAnswerLabel: UILabel!
    @IBOutlet weak var StarGasStationAnswer: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        [NicknameAnswerLabel,
         FindGasStationAnswerLabel,
         InformationErrorAnswerLabel,
         StarGasStationAnswer].forEach {
            $0?.isHidden = true
        }
    }
    
    @IBAction func NicknameChangeQuestionButtonTapped(_ sender: UIButton) {
        NicknameAnswerLabel.isHidden = false
        [FindGasStationAnswerLabel,
         InformationErrorAnswerLabel,
         StarGasStationAnswer].forEach {
            $0?.isHidden = true
        }
    }
    
    @IBAction func FindGasStationQuestionButtonTapped(_ sender: UIButton) {
        FindGasStationAnswerLabel.isHidden = false
        [NicknameAnswerLabel,
         InformationErrorAnswerLabel,
         StarGasStationAnswer].forEach {
            $0?.isHidden = true
        }
    }
    
    @IBAction func InformationErrorQuestionButtonTapped(_ sender: UIButton) {
        InformationErrorAnswerLabel.isHidden = false
        [NicknameAnswerLabel,
         FindGasStationAnswerLabel,
         StarGasStationAnswer].forEach {
            $0?.isHidden = true
        }
    }
    
    @IBAction func StarGasStationQeustionButtonTapped(_ sender: UIButton) {
        StarGasStationAnswer.isHidden = false
        [NicknameAnswerLabel,
         FindGasStationAnswerLabel,
         InformationErrorAnswerLabel].forEach {
            $0?.isHidden = true
        }
    }
    // 여기까즹
}
