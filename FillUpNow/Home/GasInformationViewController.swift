//
//  GasInformationViewController.swift
//  FillUpNow
//
//  Created by 한소희 on 2023/06/05.
//

import UIKit
import SnapKit

final class GasInformationViewController: UIViewController {
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        label.textColor = .label
        label.text = "CJ대한통운㈜ 인천주유소"
        label.numberOfLines = 0
        
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .semibold)
        label.textColor = .secondaryLabel
        label.text = "인천 중구 서해대로417번길 48"
        label.numberOfLines = 0
        
        return label
    }()
    
    private let premiumGasolineLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 1
        label.text = "고급휘발유: 0000원"
        
        return label
    }()
    
    private let gasolineLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 1
        label.text = "휘발유: 0000원"
        
        return label
    }()
    
    private let lightFuelLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 1
        label.text = "경유: 0000원"
        
        return label
    }()
    
    private let selfLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 1
        label.text = "셀프 주유가 가능한 곳이에요! 😸"
        
        return label
    }()
    
    private let starTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25.0, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 1
        
        
        return label
    }()
    
    private let starSetButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.tintColor = .systemYellow
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
    }
   
}

// MARK: -Set Up View / Layout
private extension GasInformationViewController {
    func setupViews() {
        [
            nameLabel,
            addressLabel,
            premiumGasolineLabel,
            gasolineLabel,
            lightFuelLabel,
            selfLabel,
            starSetButton
        ].forEach {
            view.addSubview($0)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(70.0)
            $0.leading.equalToSuperview().offset(30.0)
            $0.width.equalTo(250.0)
        }
        
        starSetButton.snp.makeConstraints {
            $0.centerY.equalTo(nameLabel)
            $0.trailing.equalToSuperview().offset(-30.0)
            $0.width.equalTo(50.0)
            $0.height.equalTo(starSetButton.snp.width)
        }
        
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.width.equalTo(250.0)
        }
        
        selfLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.top.equalTo(addressLabel.snp.bottom).offset(60.0)
            $0.width.equalTo(240)
        }
        
        
        lightFuelLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.top.equalTo(selfLabel.snp.bottom).offset(60)
            $0.width.equalTo(180.0)
        }
        
        gasolineLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.top.equalTo(lightFuelLabel.snp.bottom).offset(30.0)
            $0.width.equalTo(180)
        }
        
        premiumGasolineLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.top.equalTo(gasolineLabel.snp.bottom).offset(30.0)
            $0.width.equalTo(180)
        }
    }
}
