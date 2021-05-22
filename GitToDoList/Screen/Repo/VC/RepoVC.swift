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
       
        setUI()
        
        
        viewModel.issueObservable
            .observeOn(MainScheduler.instance)
            .bind(to: repoTableView.rx.items(cellIdentifier: IssueTVC.identifier, cellType: IssueTVC.self)) { _, item, cell in
                cell.titleLabel.text = item.title
                cell.subTitleLabel.text = "#\(item.number) opened 1 hour ago"
                cell.isOpenSwitch.isOn = item.state == "open" ? false : true
                cell.index = item.id
                
                cell.labelCollectionView.dataSource = nil
                cell.labelCollectionView.delegate = nil
                
                // labelCollectionView Datasource, Delegate
                let labelObservable = BehaviorSubject<[Label]>(value: item.labels ?? [])
                labelObservable.bind(to: cell.labelCollectionView.rx.items(cellIdentifier: LabelCVC.identifier, cellType: LabelCVC.self)) { _, it, c in
                    c.labelLabel.text = it.name
                    c.layer.cornerRadius = 10
                    c.backgroundColor = UIColor.init(hex: it.color)
                }
                .disposed(by: self.disposeBag)
                
                cell.onChange = { [weak self] i in
                    self?.viewModel.changeState(index: i)
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
    @IBOutlet weak var shadowView: UIView!
    
    // MARK: - private methods
    private func setUI() {
        shadowView.layer.shadowColor = UIColor.darkGray.cgColor
        shadowView.layer.shadowRadius = 0.5
        shadowView.layer.shadowOpacity = 4.0
    }
}
