//
//  RepoViewModel.swift
//  GitToDoList
//
//  Created by 이재용 on 2021/05/15.
//

import RxSwift
import Foundation

class RepoViewModel {
    
    // 전체 이슈들
    var issueObservable = BehaviorSubject<[IssueInfo]>(value: [])
    
    // 이슈 개수
    lazy var issueCount = issueObservable.map { $0.count }
    
    init() {
        // 서버에서 이슈 받아오는 코드
        _ = TestAPIService.getAllIssuesRx()
            .map { (data) -> [IssueInfo] in
                print(data)
                guard let response = try? JSONDecoder().decode([IssueInfo].self, from: data) else {
                    print("Decode Error! ㅠㅠ")
                    return []
                }
                return response
            }
            .subscribe(onNext: { data in
                // 미리 만들어둔 Observable에 데이터 update
                self.issueObservable.onNext(data)
            })
        
    }
    
    func checkAll() {
        _ = issueObservable
            .map { issues in
                var check: Bool = false
                issues.forEach { i in
                    if i.state == "close" {
                        check = true
                    }
                }
            return issues.map { i in
                if check {
                    return IssueInfo(id: i.id,
                                     title: i.title,
                                     labels: i.labels,
                                     number: i.number,
                                     state: "open",
                                     repository: i.repository,
                                     assignee: i.assignee,
                                     createdAt: i.createdAt)
                } else {
                    return IssueInfo(id: i.id,
                                     title: i.title,
                                     labels: i.labels,
                                     number: i.number,
                                     state: "close",
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
