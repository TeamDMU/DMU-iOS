//
//  Networking.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/26/24.
//

import Foundation

import Moya

protocol Networking {
    var provider: MoyaProvider<APIService> { get }

    func request(_ service: APIService, completion: @escaping (Result<Moya.Response, MoyaError>) -> Void)
}

extension Networking {
    func request(_ service: APIService, completion: @escaping (Result<Moya.Response, MoyaError>) -> Void) {
        provider.request(service) { result in
            completion(result)
        }
    }
}
