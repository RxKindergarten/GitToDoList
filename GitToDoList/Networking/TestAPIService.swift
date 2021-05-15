//
//  TestAPIService.swift
//  GitToDoList
//
//  Created by 이재용 on 2021/05/15.
//

import Foundation
import RxSwift
import KeychainSwift

let issueURL = "https://api.github.com/user/issues"
class TestAPIService {
    static func fetchAllIssues(completion: @escaping (Result<Data, Error>) -> Void) {
        let urlComponents = URLComponents(string: issueURL)!
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        let token = KeychainSwift().get("accessToken")!
        request.addValue("token \(token)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, res, err in
            if let err = err {
                completion(.failure(err))
                return
            }
            guard let data = data else {
                guard let httpResponse = res as? HTTPURLResponse else { return }
                completion(.failure(NSError(domain: "No data",
                                            code: httpResponse.statusCode,
                                            userInfo: nil)))
                return
            }
            
            
            completion(.success(data))
        }.resume()
    }
    
    func jsonParsing(_ data: Data) {
        let parser: JSONEncoder
        
    }
}
