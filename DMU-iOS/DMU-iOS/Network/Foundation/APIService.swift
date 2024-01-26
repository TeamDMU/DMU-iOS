//
//  APIService.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/26/24.
//

import Foundation

import Moya

enum APIService {
    case getSchedules(year: Int, month: Int)
}

extension APIService: TargetType {
    var baseURL: URL {
        guard let url = URL(string: APIConstants.baseURL) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getSchedules:
            return APIConstants.schedulesEndpoint
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getSchedules:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getSchedules:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return APIConstants.noTokenHeader
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
