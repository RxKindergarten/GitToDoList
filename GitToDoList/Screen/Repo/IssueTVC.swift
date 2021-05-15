//
//  IssueTVC.swift
//  GitToDoList
//
//  Created by 이재용 on 2021/05/12.
//

import RxCocoa
import RxSwift
import UIKit

class IssueTVC: UITableViewCell {
    static let identifier: String = "IssueTVC"    
    
    var index: Int?
    var onChange: ((Int) -> Void)?
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
    // MARK: - IB
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var isOpenSwitch: UISwitch!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var labelCollectionView: UICollectionView!
    
    @IBAction func changeState(_ sender: UISwitch) {
        onChange?(index!)
    }
}
