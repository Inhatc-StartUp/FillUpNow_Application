//
//  userDTO.swift
//  FillUpNow
//
//  Created by 표유림 on 2023/04/09.
//

import Foundation

struct userDTO: Codable {
    var nickname: String
    var choiceOil: String
    var choiceGasStation: String
    var choiceSelf: String
    
    init(nickname: String, choiceOil: String, choiceGasStation: String, choiceSelf: String) {
        self.nickname = nickname
        self.choiceOil = choiceOil
        self.choiceGasStation = choiceGasStation
        self.choiceSelf = choiceSelf
    }
}
