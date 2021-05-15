//
//  RepoVC.swift
//  GitToDoList
//
//  Created by 이재용 on 2021/04/17.
//

import RxCocoa
import RxSwift
import UIKit

class RepoVC: UIViewController {
    
    let viewModel = RepoViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        viewModel.issueSubject
            .observeOn(MainScheduler.instance)
            .bind(to: repoTableView.rx.items(cellIdentifier: IssueTVC.identifier, cellType: IssueTVC.self)) { _, item, cell in

                cell.titleLabel.text = item.title
                cell.subTitleLabel.text = item.subTitle
                cell.labelLabel.text = item.label
            }
            .disposed(by: disposeBag)
        
        viewModel.issueCount
            .map { "\($0)"}
            .observeOn(MainScheduler.instance)
            .bind(to: issueCountLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    @IBOutlet weak var repoTableView: UITableView!
    @IBOutlet weak var issueCountLabel: UILabel!
    
}

struct Issue {
    var title: String
    var subTitle: String
    var label: String
}

enum CellType {
    case header
    case issue
}
