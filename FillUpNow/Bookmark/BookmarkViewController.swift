//
//  StarViewController.swift
//  FillUpNow
//
//  Created by 한소희 on 2023/03/25.
//

import UIKit

final class BookmarkViewController: UIViewController{

    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let nibName = UINib(nibName: "gasStationListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "gasStationListCell")
    }
}

