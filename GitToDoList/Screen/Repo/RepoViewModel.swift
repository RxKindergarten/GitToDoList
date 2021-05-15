//
//  RepoViewModel.swift
//  GitToDoList
//
//  Created by 이재용 on 2021/05/15.
//

import RxSwift
import Foundation

class RepoViewModel {
    
    var issueObservable = BehaviorSubject<[IssueInfo]>(value: [])
    lazy var issueCount = issueObservable.map { $0.count }
    
    init() {
        // 서버에서 이슈리스트 받아오는 코드
        _ = TestAPIService.getAllIssuesRx()
            .map { data -> [IssueInfo] in
                guard let response = try? JSONDecoder().decode([IssueInfo].self, from: data) else {
                    print("Decode Error! ㅠㅠ")
                    return []
                }
                return response
                
            }
            .take(1)
            .subscribe(onNext: { data in
                // 미리 만들어둔 Observable에 데이터 update
                self.issueObservable.onNext(data)
            })
        
    }
    
    func checkAll() {
//        _ = issueSubject.map { issue in
//            return issue.map { i in
//                if i.state ==
//                return IssueInfo(id: i.id, title: i.title, labels: i.labels, number: i.number, state: i.state, repository: <#T##Repository#>, assignee: <#T##Assignee#>, createdAt: <#T##String#>)
//            }
//        }
//        .take(1)
//        .subscribe(onNext: {
//            self.issueSubject.onNext($0)
//        })
    }
    
    func changeState(index: Int) {
        _ = issueObservable
            .observeOn(MainScheduler.asyncInstance)
            .map { issue in
                return issue.map { i in
                    var state = ""
                    if i.state == "open" {
                        // 이슈 닫는 api 추가
                        state = "close"
                    } else {
                        // 이슈 여는 api 추가
                        state = "open"
                    }
                    if i.id == index {
                        return IssueInfo(id: i.id,
                                         title: i.title,
                                         labels: i.labels,
                                         number: i.number,
                                         state: state,
                                         repository: i.repository,
                                         assignee: i.assignee,
                                         createdAt: i.createdAt)
                    } else {
                        return IssueInfo(id: i.id,
                                         title: i.title,
                                         labels: i.labels,
                                         number: i.number,
                                         state: i.state,
                                         repository: i.repository,
                                         assignee: i.assignee,
                                         createdAt: i.createdAt)
                    }
                }
            }
            .take(1)
            .subscribe(onNext: {
                self.issueObservable.onNext($0)
            })
    }
}
