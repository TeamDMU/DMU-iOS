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
    case getUniversityNotices(page: Int, size: Int)
    case getDepartmentNotices(department: String, page: Int, size: Int)
    case getSearchNotices(searchWord: String, department: String, page: Int, size: Int)
    
    case postInitToken(token: String, department: String, topics: [String])
    case postUpdateKeyword(token: String, topics: [String])
    case postDeleteKeyword(token: String)
    case postUpdateDepartment(token: String, department: String)
    case postDeleteDepartment(token: String)
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
        case .getUniversityNotices(_, _):
            return APIConstants.universityNoticeEndpoint
        case .getDepartmentNotices(let department, _, _):
            return "\(APIConstants.departmentNoticeEndpoint)/\(department)"
        case .getSearchNotices(let searchWord, _, _, _):
            return "\(APIConstants.searchNoticeEndpoint)/\(searchWord)"
        
        case .postInitToken:
            return APIConstants.initTokenEndpoint
        case .postUpdateKeyword:
            return APIConstants.updateKeywordEndpoint
        case .postDeleteKeyword:
            return APIConstants.deleteKeywordEndpoint
        case .postUpdateDepartment:
            return APIConstants.updateDepartmentEndpoint
        case .postDeleteDepartment:
            return APIConstants.deleteDepartmentEndpoint
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getSchedules, .getMenus, .getUniversityNotices, .getDepartmentNotices, .getSearchNotices:
            return .get
        case .postInitToken, .postUpdateKeyword, .postDeleteKeyword, .postUpdateDepartment, .postDeleteDepartment:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getSchedules, .getMenus :
            return .requestPlain
        case .getUniversityNotices(let page, let size) :
            return .requestParameters(parameters: ["page": page, "size": size], encoding: URLEncoding.queryString)
        case .getDepartmentNotices(_, let page, let size) :
            return .requestParameters(parameters: ["page": page, "size": size], encoding: URLEncoding.queryString)
        case .getSearchNotices(_, let department, let page, let size):
            return .requestParameters(parameters: ["department": department, "page": page, "size": size], encoding: URLEncoding.queryString)
        
        case .postInitToken(let token, let department, let topics):
            return .requestParameters(parameters: ["token": token, "department": department, "topics": topics], encoding: JSONEncoding.default)
        case .postUpdateKeyword(let token, let topics):
            return .requestParameters(parameters: ["token": token, "topics": topics], encoding: JSONEncoding.default)
        case .postDeleteKeyword(let token):
            return .requestParameters(parameters: ["token": token], encoding: JSONEncoding.default)
        case .postUpdateDepartment(let token, let department):
            return .requestParameters(parameters: ["token": token, "department": department], encoding: JSONEncoding.default)
        case .postDeleteDepartment(let token):
            return .requestParameters(parameters: ["token": token], encoding: JSONEncoding.default)
            
        }
    }
    
    var headers: [String : String]? {
        return APIConstants.noTokenHeader
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
