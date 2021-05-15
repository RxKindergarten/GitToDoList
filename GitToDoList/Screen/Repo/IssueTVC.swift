//
//  IssueTVC.swift
//  GitToDoList
//
//  Created by 이재용 on 2021/05/12.
//

import UIKit

class IssueTVC: UITableViewCell {
    static let identifier: String = "IssueTVC"    
    
    var index: Int?
    var onChange: ((Int) -> Void)?
    
    @IBAction func changeState(_ sender: UISwitch) {
        onChange?(index!)
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var labelLabel: UILabel!
    @IBOutlet weak var isOpenSwitch: UISwitch!
    @IBOutlet weak var subTitleLabel: UILabel!
    
}
