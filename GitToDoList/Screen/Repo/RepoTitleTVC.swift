//
//  RepoTitleTVC.swift
//  GitToDoList
//
//  Created by 이재용 on 2021/05/12.
//

import UIKit

class RepoTitleTVC: UITableViewCell {
    static let identifier: String = "RepoTitleTVC"
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Repository Issues"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subTitle: UILabel = {
        let label = UILabel()
        label.text = "Issues categorized by your repositories"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

extension RepoTitleTVC {
    // MARK: - Private Method
    private func setLayout() {
        addSubview(title)
        
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        addSubview(subTitle)
        subTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20).isActive = true
        subTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
    }

}
