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
import SwiftyJSON

class CompleteUrlLoggerPlugin : PluginType {
    
    
    func willSend(_ request: RequestType, target: TargetType) {
        print(JSON(request.request?.httpBody) ?? "Something is wrong")
    }
}

public struct Constants {
    public static let testAPIBaseURL = URL(string: "http://139.198.126.104:8080")!
//    public static let testAPIBaseURL = URL(string: "https://jsonplaceholder.typicode.com")!
}


class MoacAPIOperation: NSObject {
    
//    lazy var provider = MoacAPIProviderFactory.makeProvider()
    
    private func JSONResponseDataFormatter(_ data: Data) -> Data {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return prettyData
        } catch {
            return data // fallback to original data if it can't be serialized.
        }
    }
    lazy var provider = MoyaProvider<MoacAPI>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])
    
    
    func auth(account: String, pwd: String) -> Promise<Data> {
        return Promise { seal in
            provider.request(.auth(account: account, pwd: pwd)) { result in
                switch result {
                case .success(let response):
                    seal.fulfill(response.data)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    func register(pwd: String, token: String) -> Promise<Data> {
        return Promise { seal in
            provider.request(.register(pwd: pwd, token: token)) { result in
                switch result {
                case .success(let response):
                    seal.fulfill(response.data)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    func login(address: String, pwd: String, keyStore: String, token: String) -> Promise<Data> {
        return Promise { seal in
            provider.request(.login(address: address, pwd: pwd, keyStore: keyStore, token: token)) { result in
                switch result {
                case .success(let response):
                    seal.fulfill(response.data)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    func getBalance(vnodeip: String, vnodeport: String, address: String, token: String) -> Promise<Data> {
        return Promise { seal in
            provider.request(.getBalance(vnodeip: vnodeip, vnodeport: vnodeport, address: address, token: token)) { result in
                switch result {
                case .success(let response):
                    seal.fulfill(response.data)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    func getBlockNumber(vnodeip: String, vnodeport: String, token: String) -> Promise<Data> {
        return Promise { seal in
            provider.request(.getBlockNumber(vnodeip: vnodeip, vnodeport: vnodeport, token: token)) { result in
                switch result {
                case .success(let response):
                    seal.fulfill(response.data)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    func getBlockInfo(vnodeip: String, vnodeport: String, block: String, token: String) -> Promise<Data> {
        return Promise { seal in
            provider.request(.getBlockInfo(vnodeip: vnodeip, vnodeport: vnodeport, block: block, token: token)) { result in
                switch result {
                case .success(let response):
                    seal.fulfill(response.data)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    func sendRawTransaction(vnodeip: String, vnodeport: String, from: String, to: String, amount: String, data: String, privatekey: String, token: String) -> Promise<Data> {
        return Promise { seal in
            provider.request(.sendRawTransaction(vnodeip: vnodeip, vnodeport: vnodeport, from: from, to: to, amount: amount, data: data, privatekey: privatekey, token: token)) { result in
                switch result {
                case .success(let response):
                    seal.fulfill(response.data)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    func callContract(vnodeip: String, vnodeport: String, contractaddress: String, method: String, paramtypes: [String], paramvalues: [String], token: String) -> Promise<Data> {
        return Promise { seal in
            provider.request(.callContract(vnodeip: vnodeip, vnodeport: vnodeport, contractaddress: contractaddress, method: method, paramtypes: paramtypes, paramvalues: paramvalues, token: token)) { result in
                switch result {
                case .success(let response):
                    seal.fulfill(response.data)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    func transferErc(vnodeip: String, vnodeport: String, from: String, to: String, contractaddress: String, amount: String, privatekey: String, token: String) -> Promise<Data> {
        return Promise { seal in
            provider.request(.transferErc(vnodeip: vnodeip, vnodeport: vnodeport, from: from, to: to, contractaddress: contractaddress, amount: amount, privatekey: privatekey, token: token)) { result in
                switch result {
                case .success(let response):
                    seal.fulfill(response.data)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    func getErcBalance(vnodeip: String, vnodeport: String, address: String, contractaddress: String, token: String) -> Promise<Data> {
        return Promise { seal in
            provider.request(.getErcBalance(vnodeip: vnodeip, vnodeport: vnodeport, address: address, contractaddress: contractaddress, token: token)) { result in
                switch result {
                case .success(let response):
                    seal.fulfill(response.data)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    func ercApprove(vnodeip: String, vnodeport: String, address: String, amount: String, privatekey: String, microchainaddress: String, contractaddress: String, token: String) -> Promise<Data> {
        return Promise { seal in
            provider.request(.ercApprove(vnodeip: vnodeip, vnodeport: vnodeport, address: address, amount: amount, privatekey: privatekey, microchainaddress: microchainaddress, contractaddress: contractaddress, token: token)) { result in
                switch result {
                case .success(let response):
                    seal.fulfill(response.data)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    func buyErcMintToken(vnodeip: String, vnodeport: String, address: String, privatekey: String, microchainaddress: String, method: String, paramtypes: [String], paramvalues: [String], token: String) -> Promise<Data> {
        return Promise { seal in
            provider.request(.buyErcMintToken(vnodeip: vnodeip, vnodeport: vnodeport, address: address, privatekey: privatekey, microchainaddress: microchainaddress, method: method, paramtypes: paramtypes, paramvalues: paramvalues, token: token)) { result in
                switch result {
                case .success(let response):
                    seal.fulfill(response.data)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    func buyMoacMintToken(vnodeip: String, vnodeport: String, address: String, privatekey: String, microchainaddress: String, method: String, paramtypes: [String], paramvalues: [String], token: String) -> Promise<Data> {
        return Promise { seal in
            provider.request(.buyMoacMintToken(vnodeip: vnodeip, vnodeport: vnodeport, address: address, privatekey: privatekey, microchainaddress: microchainaddress, method: method, paramtypes: paramtypes, paramvalues: paramvalues, token: token)) { result in
                switch result {
                case .success(let response):
                    seal.fulfill(response.data)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    func getBlockNumberMicro(microip: String, microport: String, microchainaddress: String, token: String) -> Promise<Data> {
        return Promise { seal in
            provider.request(.getBlockNumberMicro(microip: microip, microport: microport, microchainaddress: microchainaddress, token: token)) { result in
                switch result {
                case .success(let response):
                    seal.fulfill(response.data)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    func getBlockMicro(microip: String, microport: String, microchainaddress: String, blocknum: String, token: String) -> Promise<Data> {
        return Promise { seal in
            provider.request(.getBlockMicro(microip: microip, microport: microport, microchainaddress: microchainaddress, blocknum: blocknum, token: token)) { result in
                switch result {
                case .success(let response):
                    seal.fulfill(response.data)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    func getBalanceMicro(microip: String, microport: String, microchainaddress: String, address: String, token: String) -> Promise<Data> {
        return Promise { seal in
            provider.request(.getBalanceMicro(microip: microip, microport: microport, microchainaddress: microchainaddress, address: address, token: token)) { result in
                switch result {
                case .success(let response):
                    seal.fulfill(response.data)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    func transferCoinMicro(vnodeip: String, vnodeport: String, microip: String, microport: String, microchainaddress: String, via: String, from: String, to: String, amount: String, privatekey: String, token: String) -> Promise<Data> {
        return Promise { seal in
            provider.request(.transferCoinMicro(vnodeip: vnodeip, vnodeport: vnodeport, microip: microip, microport: microport, microchainaddress: microchainaddress, via: via, from: from, to: to, amount: amount, privatekey: privatekey, token: token)) { result in
                switch result {
                case .success(let response):
                    seal.fulfill(response.data)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    func sendRawTransactionMicro(vnodeip: String, vnodeport: String, microip: String, microport: String, from: String, microchainaddress: String, via: String, amount: String, dappaddress: String, data: String, privatekey: String, token: String) -> Promise<Data> {
        return Promise { seal in
            provider.request(.sendRawTransactionMicro(vnodeip: vnodeip, vnodeport: vnodeport, microip: microip, microport: microport, from: from, microchainaddress: microchainaddress, via: via, amount: amount, dappaddress: dappaddress, data: data, privatekey: privatekey, token: token)) { result in
                switch result {
                case .success(let response):
                    seal.fulfill(response.data)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    func callContractMicro(microip: String, microport: String, microchainaddress: String, dappaddress: String, data: String, token: String) -> Promise<Data> {
        return Promise { seal in
            provider.request(.callContractMicro(microip: microip, microport: microport, microchainaddress: microchainaddress, dappaddress: dappaddress, data: data, token: token)) { result in
                switch result {
                case .success(let response):
                    seal.fulfill(response.data)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    func redeemMintToken(vnodeip: String, vnodeport: String, microip: String, microport: String, microchainaddress: String, dappaddress: String, address: String, amount: String, privatekey: String, token: String) -> Promise<Data> {
        return Promise { seal in
            provider.request(.redeemMintToken(vnodeip: vnodeip, vnodeport: vnodeport, microip: microip, microport: microport, microchainaddress: microchainaddress, dappaddress: dappaddress, address: address, amount: amount, privatekey: privatekey, token: token)) { result in
                switch result {
                case .success(let response):
                    seal.fulfill(response.data)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
}

struct ResBodyJSON: Encodable {
    let success: Bool
    let message: String
    let data: String
}

enum MoacAPI {
    case auth(account: String, pwd: String)
    case register(pwd: String, token: String)
    case login(address: String, pwd: String, keyStore: String, token: String)
    case getBalance(vnodeip: String, vnodeport: String, address: String, token: String)
    case getBlockNumber(vnodeip: String, vnodeport: String, token: String)
    case getBlockInfo(vnodeip: String, vnodeport: String, block: String, token: String)
    case sendRawTransaction(vnodeip: String, vnodeport: String, from: String, to: String, amount: String, data: String, privatekey: String, token: String)
    case callContract(vnodeip: String, vnodeport: String, contractaddress: String, method: String, paramtypes: [String], paramvalues: [String], token: String)
    case transferErc(vnodeip: String, vnodeport: String, from: String, to: String, contractaddress: String, amount: String, privatekey: String, token: String)
    case getErcBalance(vnodeip: String, vnodeport: String, address: String, contractaddress: String, token: String)
    case ercApprove(vnodeip: String, vnodeport: String, address: String, amount: String, privatekey: String, microchainaddress: String, contractaddress: String, token: String)
    case buyErcMintToken(vnodeip: String, vnodeport: String, address: String, privatekey: String, microchainaddress: String, method: String, paramtypes: [String], paramvalues: [String], token: String)
    case buyMoacMintToken(vnodeip: String, vnodeport: String, address: String, privatekey: String, microchainaddress: String, method: String, paramtypes: [String], paramvalues: [String], token: String)
    case getBlockNumberMicro(microip: String, microport: String, microchainaddress: String, token: String)
    case getBlockMicro(microip: String, microport: String, microchainaddress: String, blocknum: String, token: String)
    case getBalanceMicro(microip: String, microport: String, microchainaddress: String, address: String, token: String)
    case transferCoinMicro(vnodeip: String, vnodeport: String, microip: String, microport: String, microchainaddress: String, via: String, from: String, to: String, amount: String, privatekey: String, token: String)
    case sendRawTransactionMicro(vnodeip: String, vnodeport: String, microip: String, microport: String, from: String, microchainaddress: String, via: String, amount: String, dappaddress: String, data: String, privatekey: String, token: String)
    case callContractMicro(microip: String, microport: String, microchainaddress: String, dappaddress: String, data: String, token: String)
    case redeemMintToken(vnodeip: String, vnodeport: String, microip: String, microport: String, microchainaddress: String, dappaddress: String, address: String, amount: String, privatekey: String, token: String)
}

extension MoacAPI: TargetType {
    
    var baseURL: URL { return Constants.testAPIBaseURL }
    
    var path: String {
        switch self {
        case .auth:
            return "/auth"
        case .register:
            return "/api/account/v1.0/register"
        case .login:
            return "/api/account/v1.0/login"
        case .getBalance:
            return "/api/vnode/v1.0/getBalance"
        case .getBlockNumber:
            return "/api/vnode/v1.0/getBlockNumber"
        case .getBlockInfo:
            return "/api/vnode/v1.0/getBlockInfo"
        case .sendRawTransaction:
            return "/api/vnode/v1.0/sendRawTransaction"
        case .callContract:
            return "/api/vnode/v1.0/callContract"
        case .transferErc:
            return "/api/vnode/v1.0/transferErc"
        case .getErcBalance:
            return "/api/vnode/v1.0/getErcBalance"
        case .ercApprove:
            return "/api/vnode/v1.0/ercApprove"
        case .buyErcMintToken:
            return "/api/vnode/v1.0/buyErcMintToken"
        case .buyMoacMintToken:
            return "/api/vnode/v1.0/buyMoacMintToken"
        case .getBlockNumberMicro:
            return "/api/micro/v1.0/getBlockNumber"
        case .getBlockMicro:
            return "/api/micro/v1.0/getBlock"
        case .getBalanceMicro:
            return "/api/micro/v1.0/getBalance"
        case .transferCoinMicro:
            return "/api/micro/v1.0/transferCoin"
        case .sendRawTransactionMicro:
            return "/api/micro/v1.0/sendRawTransaction"
        case .callContractMicro:
            return "/api/micro/v1.0/callContract"
        case .redeemMintToken:
            return "/api/micro/v1.0/redeemMintToken"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .auth: return .post
        case .register: return .post
        case .login: return .post
        case .getBalance: return .post
        case .getBlockNumber: return .post
        case .getBlockInfo: return .post
        case .sendRawTransaction: return .post
        case .callContract: return .post
        case .transferErc: return .post
        case .getErcBalance: return .post
        case .ercApprove: return .post
        case .buyErcMintToken: return .post
        case .buyMoacMintToken: return .post
        case .getBlockNumberMicro: return .post
        case .getBlockMicro: return .post
        case .getBalanceMicro: return .post
        case .transferCoinMicro: return .post
        case .sendRawTransactionMicro: return .post
        case .callContractMicro: return .post
        case .redeemMintToken: return .post
        }
    }
    
    var task: Task {
        switch self {
        case .auth(let account, let pwd):
            return .requestParameters(parameters: ["account": account, "pwd": pwd], encoding: URLEncoding.default)
        case .register(let pwd, let token):
            return .requestParameters(parameters: ["pwd": pwd, "token": token], encoding: URLEncoding.default)
        case .login(let address, let pwd, let keyStore, let token):
            return .requestParameters(parameters: ["address": address, "pwd": pwd, "keystore": keyStore, "token": token],encoding: URLEncoding.default)
        case .getBalance(let vnodeip, let vnodeport, let address, let token):
            return .requestParameters(parameters: ["vnodeip": vnodeip, "vnodeport": vnodeport, "address": address, "token": token], encoding: URLEncoding.default)
        case .getBlockNumber(let vnodeip, let vnodeport, let token):
            return .requestParameters(parameters: ["vnodeip": vnodeip, "vnodeport": vnodeport, "token": token], encoding: URLEncoding.default)
        case .getBlockInfo(let vnodeip, let vnodeport, let block, let token):
            return .requestParameters(parameters: ["vnodeip": vnodeip, "vnodeport": vnodeport, "block": block, "token": token], encoding: URLEncoding.default)
        case .sendRawTransaction(let vnodeip, let vnodeport, let from, let to, let amount, let data, let privatekey, let token):
            return .requestParameters(parameters: ["vnodeip": vnodeip, "vnodeport": vnodeport, "from": from, "to": to, "amount": amount, "data": data, "privatekey": privatekey, "token": token], encoding: URLEncoding.default)
        case .callContract(let vnodeip, let vnodeport, let contractaddress, let method, let paramtypes, let paramvalues, let token):
            return .requestParameters(parameters: ["vnodeip": vnodeip, "vnodeport": vnodeport, "contractaddress": contractaddress, "method": method, "paramtypes": paramtypes, "paramvalues": paramvalues, "token": token], encoding: URLEncoding.default)
        case .transferErc(let vnodeip, let vnodeport, let from, let to, let contractaddress, let amount, let privatekey, let token):
            return .requestParameters(parameters: ["vnodeip": vnodeip, "vnodeport": vnodeport, "from": from, "to": to, "contractaddress": contractaddress, "amount": amount, "privatekey": privatekey, "token": token], encoding: URLEncoding.default)
        case .getErcBalance(let vnodeip, let vnodeport, let address, let contractaddress, let token):
            return .requestParameters(parameters: ["vnodeip": vnodeip, "vnodeport": vnodeport, "address": address, "contractaddress": contractaddress, "token": token], encoding: URLEncoding.default)
        case .ercApprove(let vnodeip, let vnodeport, let address, let amount, let privatekey, let microchainaddress, let contractaddress, let token):
            return .requestParameters(parameters: ["vnodeip": vnodeip, "vnodeport": vnodeport, "address": address, "amount": amount, "privatekey": privatekey, "microchainaddress": microchainaddress, "contractaddress": contractaddress, "token": token], encoding: URLEncoding.default)
        case .buyErcMintToken(let vnodeip, let vnodeport, let address, let privatekey, let microchainaddress, let method, let paramtypes, let paramvalues, let token):
            return .requestParameters(parameters: ["vnodeip": vnodeip, "vnodeport": vnodeport, "address": address, "privatekey": privatekey, "microchainaddress": microchainaddress, "method": method, "paramtypes": paramtypes, "paramvalues": paramvalues, "token": token], encoding: URLEncoding.default)
        case .buyMoacMintToken(let vnodeip, let vnodeport, let address, let privatekey, let microchainaddress, let method, let paramtypes, let paramvalues, let token):
            return .requestParameters(parameters: ["vnodeip": vnodeip, "vnodeport": vnodeport, "address": address, "privatekey": privatekey, "microchainaddress": microchainaddress, "method": method, "paramtypes": paramtypes, "paramvalues": paramvalues, "token": token], encoding: URLEncoding.default)
        case .getBlockNumberMicro(let microip, let microport, let microchainaddress, let token):
            return .requestParameters(parameters: ["microip": microip, "microport": microport, "microchainaddress": microchainaddress, "token": token], encoding: URLEncoding.default)
        case .getBlockMicro(let microip, let microport, let microchainaddress, let blocknum, let token):
            return .requestParameters(parameters: ["microip": microip, "microport": microport, "microchainaddress": microchainaddress, "blocknum": blocknum, "token": token], encoding: URLEncoding.default)
        case .getBalanceMicro(let microip, let microport, let microchainaddress, let address, let token):
            return .requestParameters(parameters: ["microip": microip, "microport": microport, "microchainaddress": microchainaddress, "address": address, "token": token], encoding: URLEncoding.default)
        case .transferCoinMicro(let vnodeip, let vnodeport, let microip, let microport, let microchainaddress, let via, let from, let to, let amount, let privatekey, let token):
            return .requestParameters(parameters: ["vnodeip": vnodeip, "vnodeport": vnodeport, "microip": microip, "microport": microport, "microchainaddress": microchainaddress, "via": via, "from": from, "to": to, "amount": amount, "privatekey": privatekey, "token": token], encoding: URLEncoding.default)
        case .sendRawTransactionMicro(let vnodeip, let vnodeport, let microip, let microport, let from, let microchainaddress, let via, let amount, let dappaddress, let data, let privatekey, let token):
            return .requestParameters(parameters: ["vnodeip": vnodeip, "vnodeport": vnodeport, "microip": microip, "microport": microport, "from": from, "microchainaddress": microchainaddress, "via": via, "amount": amount, "dappaddress": dappaddress, "data": data, "privatekey": privatekey, "token": token], encoding: URLEncoding.default)
        case .callContractMicro(let microip, let microport, let microchainaddress, let dappaddress, let data, let token):
            return .requestParameters(parameters: ["microip": microip, "microport": microport, "microchainaddress": microchainaddress, "dappaddress": dappaddress, "data": data, "token": token], encoding: URLEncoding.default)
        case .redeemMintToken(let vnodeip, let vnodeport, let microip, let microport, let microchainaddress, let dappaddress, let address, let amount, let privatekey, let token):
            return .requestParameters(parameters: ["vnodeip": vnodeip, "vnodeport": vnodeport, "microip": microip, "microport": microport, "microchainaddress": microchainaddress, "dappaddress": dappaddress, "address": address, "amount": amount, "privatekey": privatekey, "token": token], encoding: URLEncoding.default)
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        return [
            "Content-type": "application/x-www-form-urlencoded; charset=UTF-8"
        ]
    }
}
