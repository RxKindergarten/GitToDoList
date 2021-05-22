//
//  TestAPIService.swift
//  GitToDoList
//
//  Created by 이재용 on 2021/05/15.
//

import Foundation
import RxSwift
import KeychainSwift

let issueURL = "https://api.github.com/user/issues?"

class TestAPIService {
    
    static func getAllIssues(completion: @escaping (Result<Data, Error>) -> Void) {
        var urlComponents = URLComponents(string: issueURL)!
        let queryItem = URLQueryItem(name: "state", value: "all")
        let queryItem2 = URLQueryItem(name: "filter", value: "all")
        urlComponents.queryItems?.append(queryItem)
        urlComponents.queryItems?.append(queryItem2)
        print(urlComponents)
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
    
    static func getAllIssuesRx() -> Observable<Data> {
        return Observable.create { emitter in
            getAllIssues { result in
                switch result {
                case .success(let data):
                    emitter.onNext(data)
                    emitter.onCompleted()
                case .failure(let err):
                    emitter.onError(err)
                }
            }
            return Disposables.create()
        }
    }
}
