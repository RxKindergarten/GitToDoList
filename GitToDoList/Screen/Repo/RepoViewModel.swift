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
            Issue(index: 0, title: "[Repo] 레포별 이슈리스트 UI 구성", subTitle: "#5 opened 1 hour ago by wody27", label: "재용", isOpen: false),
            Issue(index: 1, title: "[Repo] 레포별 이슈리스트 UI 구성", subTitle: "#5 opened 1 hour ago by wody27", label: "재용", isOpen: false),
            Issue(index: 2, title: "[Repo] 레포별 이슈리스트 UI 구성", subTitle: "#5 opened 1 hour ago by wody27", label: "재용", isOpen: false),
            Issue(index: 3, title: "[Repo] 레포별 이슈리스트 UI 구성", subTitle: "#5 opened 1 hour ago by wody27", label: "재용", isOpen: false),
            Issue(index: 4, title: "[Repo] 레포별 이슈리스트 UI 구성", subTitle: "#5 opened 1 hour ago by wody27", label: "재용", isOpen: false),
            Issue(index: 5, title: "[Repo] 레포별 이슈리스트 UI 구성", subTitle: "#5 opened 1 hour ago by wody27", label: "재용", isOpen: false),
            Issue(index: 6, title: "[Repo] 레포별 이슈리스트 UI 구성", subTitle: "#5 opened 1 hour ago by wody27", label: "재용", isOpen: false),
            Issue(index: 7, title: "[Repo] 레포별 이슈리스트 UI 구성", subTitle: "#5 opened 1 hour ago by wody27", label: "재용", isOpen: false),
            Issue(index: 8, title: "[Repo] 레포별 이슈리스트 UI 구성", subTitle: "#5 opened 1 hour ago by wody27", label: "재용", isOpen: false)
        ]
        
        issueSubject.onNext(issues)
    }
    
    func checkAll() {
        _ = issueSubject.map { issue in
            return issue.map { ind in
                return Issue(index: ind.index,
                             title: ind.title,
                             subTitle: ind.subTitle,
                             label: ind.label,
                             isOpen: !ind.isOpen)
            }
        }
        .take(1)
        .subscribe(onNext: {
            self.issueSubject.onNext($0)
        })
    }
    
    func changeState(index: Int) {
        _ = issueSubject
            .observeOn(MainScheduler.asyncInstance)
            .map { issue in
                return issue.map { ind in
                    if ind.index == index {
                        return Issue(index: ind.index,
                                     title: ind.title,
                                     subTitle: ind.subTitle,
                                     label: ind.label,
                                     isOpen: !ind.isOpen)
                    } else {
                        return Issue(index: ind.index,
                                     title: ind.title,
                                     subTitle: ind.subTitle,
                                     label: ind.label,
                                     isOpen: ind.isOpen)
                    }
                }
            }
            .take(1)
            .subscribe(onNext: {
                self.issueSubject.onNext($0)
            })
    }
}
