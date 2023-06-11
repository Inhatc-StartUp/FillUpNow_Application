//
//  gasStationListCell.swift
//  FillUpNow
//
//  Created by 표유림 on 2023/05/07.
//

import UIKit

class gasStationListCell: UITableViewCell {
    
    @IBOutlet var shopNameCell: UILabel!
    
    @IBOutlet var showAddressCell: UILabel!
    
    @IBOutlet var detailCell: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
