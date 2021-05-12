//
//  RepoVC.swift
//  GitToDoList
//
//  Created by 이재용 on 2021/04/17.
//

import UIKit

class RepoVC: UIViewController {

    @IBOutlet weak var repoTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        repoTableView.delegate = self
        repoTableView.dataSource = self
        repoTableView.rowHeight = UITableView.automaticDimension
        repoTableView.estimatedRowHeight = 44.0
    }
    
}

extension RepoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepoTitleTVC.identifier) as? RepoTitleTVC else { return UITableViewCell() }
        
        return cell
    }
    
    
}
