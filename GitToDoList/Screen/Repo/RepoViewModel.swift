//
//  RepoViewModel.swift
//  GitToDoList
//
//  Created by 이재용 on 2021/05/15.
//

import RxSwift
import Foundation

class RepoViewModel {
    
    var issueSubject = BehaviorSubject<[Issue]>(value: [])
    lazy var issueCount = issueSubject.map { $0.count }
    
    init() {
        let issues: [Issue] = [
            Issue(title: "[Repo] 레포별 이슈리스트 UI 구성", subTitle: "#5 opened 1 hour ago by wody27", label: "재용"),
            Issue(title: "[Repo] 레포별 이슈리스트 UI 구성", subTitle: "#5 opened 1 hour ago by wody27", label: "재용"),
            Issue(title: "[Repo] 레포별 이슈리스트 UI 구성", subTitle: "#5 opened 1 hour ago by wody27", label: "재용"),
            Issue(title: "[Repo] 레포별 이슈리스트 UI 구성", subTitle: "#5 opened 1 hour ago by wody27", label: "재용")
        ]
        
        issueSubject.onNext(issues)
    }
}
