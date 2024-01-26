//
//  APIConstants.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/26/24.
//

import Foundation

// API에 필요한 상수 정의
struct APIConstants {
    static var baseURL: String {
        return Bundle.main.readSecret(key: "baseURL") ?? "Fallback URL"
    }
    
    static let schedulesEndpoint = "scheduler"
    
    static let contentType = "Content-Type"
    static let applicationJSON = "application/json"
    static let multipartFormData = "multipart/form"
}

extension APIConstants {
    static var noTokenHeader: Dictionary<String, String> {
        [contentType: applicationJSON]
    }
}

// Bundle Extension -> Secrets.plist 데이터 가져오기
extension Bundle {
    func readSecret(key: String) -> String? {
        guard let path = self.path(forResource: "Secrets", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let value = dict[key] as? String else {
            return nil
        }
        
        return value
    }
}
