//
//  MoacAPI.swift
//  MoacAPI
//
//  Created by Liwei Zhang on 2019-02-25.
//  Copyright © 2019 Liwei Zhang. All rights reserved.
//

import Foundation
import Moya
import PromiseKit
import BigInt

public struct Constants {
    public static let testAPIBaseURL = URL(string: "https://jsonplaceholder.typicode.com")!
//    public static let testAPIBaseURL = URL(string: "https://jsonplaceholder.typicode.com")!
}


class MoacAPIOperation: NSObject {
    
    lazy var provider = MoacAPIProviderFactory.makeProvider()
    
    
    func postTest() -> Promise<Any> {
        
        return Promise { seal in
            provider.request(.postAny(reqJSON: ReqBodyJSON(title: "hahah", body: "ha**21", userId: 342))) { result in
                switch result {
                case .success(let response):
                    print("OK:")
                    print(response)
                    seal.fulfill(response)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    func getTest() -> Promise<Any> {
        
        return Promise { seal in
            provider.request(.getAny) { result in
                switch result {
                case .success(let response):
                    print("OK:")
                    print(response)
                    seal.fulfill(response)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
}

struct ReqBodyJSON: Encodable {
    let title: String
    let body: String
    let userId: Int
}

enum MoacAPI {
    case postAny(reqJSON: ReqBodyJSON)
    case getAny
}

extension MoacAPI: TargetType {
    
    var baseURL: URL { return Constants.testAPIBaseURL }
    
    var path: String {
        switch self {
        case .postAny:
            return "/posts"
        case .getAny:
            return "/posts/1"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postAny: return .post
        case .getAny: return .get
        }
    }
    
    var task: Task {
        switch self {
        case .postAny(let reqJSON):
            return .requestJSONEncodable(reqJSON)
        case .getAny:
            return .requestPlain
        
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        return [
            "Content-type": "application/json; charset=UTF-8"
        ]
    }
}
