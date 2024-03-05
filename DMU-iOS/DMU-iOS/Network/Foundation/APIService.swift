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
    case getMenus
    case getUniversityNotices
    case getDepartmentNotices(department: String)
    case getSearchNotices(searchWord: String, department: String, page: Int, size: Int)
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
            return APIConstants.scheduleEndpoint
        case .getMenus:
            return APIConstants.menuEndpoint
        case .getUniversityNotices:
            return APIConstants.universityNoticeEndpoint
        case .getDepartmentNotices(let department):
            return "\(APIConstants.departmentNoticeEndpoint)/\(department)"
        case .getSearchNotices(let searchWord, _, _, _):
            return "\(APIConstants.searchNoticeEndpoint)/\(searchWord)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getSchedules, .getMenus, .getUniversityNotices, .getDepartmentNotices, .getSearchNotices:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getSchedules, .getMenus, .getUniversityNotices, .getDepartmentNotices:
            return .requestPlain
        case .getSearchNotices(_, let department, let page, let size):
            return .requestParameters(parameters: ["department": department, "page": page, "size": size], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return APIConstants.noTokenHeader
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
