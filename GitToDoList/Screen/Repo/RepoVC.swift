//
//  RepoVC.swift
//  GitToDoList
//
//  Created by 이재용 on 2021/04/17.
//

import UIKit

struct Issue {
    var title: String
    var subTitle: String
    var label: String
}

enum CellType {
    case header
    case issue
}
class RepoVC: UIViewController {
    
    var issues: [Issue] = [
        Issue(title: "[Repo] 레포별 이슈리스트 UI 구성", subTitle: "#5 opened 1 hour ago by wody27", label: "재용"),
        Issue(title: "[Repo] 레포별 이슈리스트 UI 구성", subTitle: "#5 opened 1 hour ago by wody27", label: "재용"),
        Issue(title: "[Repo] 레포별 이슈리스트 UI 구성", subTitle: "#5 opened 1 hour ago by wody27", label: "재용"),
        Issue(title: "[Repo] 레포별 이슈리스트 UI 구성", subTitle: "#5 opened 1 hour ago by wody27", label: "재용")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repoTableView.delegate = self
        repoTableView.dataSource = self
        repoTableView.rowHeight = UITableView.automaticDimension
        repoTableView.estimatedRowHeight = 44.0
    }
    
    @IBOutlet weak var repoTableView: UITableView!
    
}

extension RepoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IssueTVC.identifier) as? IssueTVC else { return UITableViewCell() }
        
        cell.titleLabel.text = issues[indexPath.row].title
        cell.subTitleLabel.text = issues[indexPath.row].subTitle
        cell.labelLabel.text = issues[indexPath.row].label
        return cell
    }
    
    
}
