//
//  IssueInfo.swift
//  GitToDoList
//
//  Created by 이재용 on 2021/05/15.
//

import Foundation

struct IssueInfo: Codable {
    let id: Int
    let title: String
    let labels: [Label]
    var state: String
    let repository: Repository
    let assignee: Assignee
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case labels
        case state
        case repository
        case assignee
    }
}

struct Label: Codable {
    let id: Int
    let name, color: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name, color
    }
}

struct Repository: Codable {
    let id: Int
    let name: String
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

struct Assignee: Codable {
    let id: Int
    let avatarURL: String
    enum CodingKeys: String, CodingKey {
        case id
        case avatarURL = "avatar_url"
    }
}
