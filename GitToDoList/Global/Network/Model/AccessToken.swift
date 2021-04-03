//
//  AccessToken.swift
//  GitToDoList
//
//  Created by 선민승 on 2021/04/03.
//

import Foundation

// MARK: - Welcome
struct AccessToken: Codable {
    let accessToken, scope, tokenType: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case scope
        case tokenType = "token_type"
    }
}
