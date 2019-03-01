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
    
    func getTest() -> Promise<Bool> {
        
        return Promise { seal in
            provider.request(.getAny) { result in
                switch result {
                case .success(let response):
                    print("OK:")
                    print(response)
                    seal.fulfill(true)
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
    case callContract(vnodeip: String, vnodeport: String, address: String, data: String, token: String)
    case transferErc(vnodeip: String, vnodeport: String, from: String, to: String, contractaddress: String, amount: String, privatekey: String, token: String)
    case getErcBalance(vnodeip: String, vnodeport: String, address: String, contractaddress: String, token: String)
    case ercApprove(vnodeip: String, vnodeport: String, address: String, amount: String, privatekey: String, microchainaddress: String, contractaddress: String, token: String)
    case buyErcMintToken(vnodeip: String, vnodeport: String, address: String, amount: String, privatekey: String, microchainaddress: String, token: String)
    case buyMoacMintToken(vnodeip: String, vnodeport: String, address: String, amount: String, privatekey: String, microchainaddress: String, token: String)
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
            return "/api/account/register"
        case .login:
            return "/api/account/login"
        case .getBalance:
            return "/api/vnode/getBalance"
        case .getBlockNumber:
            return "/api/vnode/getBlockNumber"
        case .getBlockInfo:
            return "/api/vnode/getBlockInfo"
        case .sendRawTransaction:
            return "/api/vnode/sendRawTransaction"
        case .callContract:
            return "/api/vnode/callContract"
        case .transferErc:
            return "/api/vnode/transferErc"
        case .getErcBalance:
            return "/api/vnode/getErcBalance"
        case .ercApprove:
            return "/api/vnode/ercApprove"
        case .buyErcMintToken:
            return "/api/vnode/buyErcMintToken"
        case .buyMoacMintToken:
            return "/api/vnode/buyMoacMintToken"
        case .getBlockNumberMicro:
            return "/api/micro/getBlockNumber"
        case .getBlockMicro:
            return "/api/micro/getBlock"
        case .getBalanceMicro:
            return "/api/micro/getBalance"
        case .transferCoinMicro:
            return "/api/micro/transferCoin"
        case .sendRawTransactionMicro:
            return "/api/micro/sendRawTransaction"
        case .callContractMicro:
            return "/api/micro/callContract"
        case .redeemMintToken:
            return "/api/micro/redeemMintToken"
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
            return .requestParameters(parameters: ["address": address, "pwd": pwd, "keyStore": keyStore, "token": token],encoding: URLEncoding.default)
        case .getBalance(let vnodeip, let vnodeport, let address, let token):
            return .requestParameters(parameters: ["vnodeip": vnodeip, "vnodeport": vnodeport, "address": address, "token": token], encoding: URLEncoding.default)
        case .getBlockNumber(let vnodeip, let vnodeport, let token):
            return .requestParameters(parameters: ["vnodeip": vnodeip, "vnodeport": vnodeport, "token": token], encoding: URLEncoding.default)
        case .getBlockInfo(let vnodeip, let vnodeport, let block, let token):
            return .requestParameters(parameters: ["vnodeip": vnodeip, "vnodeport": vnodeport, "block": block, "token": token], encoding: URLEncoding.default)
        case .sendRawTransaction(let vnodeip, let vnodeport, let from, let to, let amount, let data, let privatekey, let token):
            return .requestParameters(parameters: ["vnodeip": vnodeip, "vnodeport": vnodeport, "from": from, "to": to, "amount": amount, "data": data, "privatekey": privatekey, "token": token], encoding: URLEncoding.default)
        case .callContract(let vnodeip, let vnodeport, let address, let data, let token):
            return .requestParameters(parameters: ["vnodeip": vnodeip, "vnodeport": vnodeport, "address": address, "data": data, "token": token], encoding: URLEncoding.default)
        case .transferErc(let vnodeip, let vnodeport, let from, let to, let contractaddress, let amount, let privatekey, let token):
            return .requestParameters(parameters: ["vnodeip": vnodeip, "vnodeport": vnodeport, "from": from, "to": to, "contractaddress": contractaddress, "amount": amount, "privatekey": privatekey, "token": token], encoding: URLEncoding.default)
        case .getErcBalance(let vnodeip, let vnodeport, let address, let contractaddress, let token):
            return .requestParameters(parameters: ["vnodeip": vnodeip, "vnodeport": vnodeport, "address": address, "contractaddress": contractaddress, "token": token], encoding: URLEncoding.default)
        case .ercApprove(let vnodeip, let vnodeport, let address, let amount, let privatekey, let microchainaddress, let contractaddress, let token):
            return .requestParameters(parameters: ["vnodeip": vnodeip, "vnodeport": vnodeport, "address": address, "amount": amount, "privatekey": privatekey, "microchainaddress": microchainaddress, "contractaddress": contractaddress, "token": token], encoding: URLEncoding.default)
        case .buyErcMintToken(let vnodeip, let vnodeport, let address, let amount, let privatekey, let microchainaddress, let token):
            return .requestParameters(parameters: ["vnodeip": vnodeip, "vnodeport": vnodeport, "address": address, "amount": amount, "privatekey": privatekey, "microchainaddress": microchainaddress, "token": token], encoding: URLEncoding.default)
        case .buyMoacMintToken(let vnodeip, let vnodeport, let address, let amount, let privatekey, let microchainaddress, let token):
            return .requestParameters(parameters: ["vnodeip": vnodeip, "vnodeport": vnodeport, "address": address, "amount": amount, "privatekey": privatekey, "microchainaddress": microchainaddress, "token": token], encoding: URLEncoding.default)
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
