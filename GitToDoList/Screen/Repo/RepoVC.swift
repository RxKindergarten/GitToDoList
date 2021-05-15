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
            
        TestAPIService.fetchAllIssues { result in
            switch result {
            case .success(let data):
                break
            case .failure(let err):
                print(err)
                break
            }
        }
        
        viewModel.issueSubject
            .observeOn(MainScheduler.instance)
            .bind(to: repoTableView.rx.items(cellIdentifier: IssueTVC.identifier, cellType: IssueTVC.self)) { _, item, cell in

                cell.titleLabel.text = item.title
                cell.subTitleLabel.text = item.subTitle
                cell.labelLabel.text = item.label
                cell.isOpenSwitch.isOn = item.isOpen
                cell.index = item.index
                
                cell.onChange = { [weak self] ind in
                    self?.viewModel.changeState(index: ind)
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.issueCount
            .map { "\($0)"}
            .observeOn(MainScheduler.instance)
            .bind(to: issueCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        checkAllButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.checkAll()
            })
            .disposed(by: disposeBag)
    }
    
    @IBOutlet weak var repoTableView: UITableView!
    @IBOutlet weak var issueCountLabel: UILabel!
    @IBOutlet weak var checkAllButton: UIButton!
  
}

struct Issue {
    var index: Int
    var title: String
    var subTitle: String
    var label: String
    var isOpen: Bool
}

enum CellType {
    case header
    case issue
}
