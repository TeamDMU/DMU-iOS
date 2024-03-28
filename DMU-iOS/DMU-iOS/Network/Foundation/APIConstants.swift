//
//  APIConstants.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/26/24.
//

import Foundation

// API에 필요한 상수 정의
struct APIConstants {
    
    // API 기본 URL, 실패 시 Fallback URL
    static var baseURL: String {
        return Bundle.main.readSecret(key: "baseURL") ?? "Fallback URL"
    }
    
    // 학사일정 API 엔드포인트
    static let scheduleEndpoint = "/api/v1/dmu/schedule"
    
    // 식단표 API 엔드포인트
    static let menuEndpoint = "/api/v1/dmu/cafeteria"
    
    // 대학공지 API 엔드포인트
    static let universityNoticeEndpoint = "/api/v1/dmu/universityNotice"
    
    // 학부공지 API 엔드포인트
    static let departmentNoticeEndpoint = "/api/v1/dmu/departmentNotice"
    
    // 공지 검색 API 엔드포인트
    static let searchNoticeEndpoint = "/api/v1/dmu/notice"
    
    // 키워드 및 학과, 토큰 초기 설정 API 엔드포인트
    static let initTokenEndpoint = "/token/v1/dmu/initToken"
    
    // 키워드 알림 업데이트 API 엔드포인트
    static let updateKeywordEndpoint = "/token/v1/dmu/update_topic"

    // 키워드 알림 삭제 API 엔드포인트
    static let deleteKeywordEndpoint = "/token/v1/dmu/delete_topic"
    
    // 학과 알림 업데이트 API 엔드포인트
    static let updateDepartmentEndpoint = "/token/v1/dmu/update_department"
    
    // 학과 알림 삭제 API 엔드포인트
    static let deleteDepartmentEndpoint = "/token/v1/dmu/delete_department"
    
    // HTTP 필드 이름
    static let contentType = "Content-Type"
    
    // HTTP 필드값
    static let applicationJSON = "application/json"
    static let multipartFormData = "multipart/form"
}

extension APIConstants {
    // 토큰이 없는 경우 사용하는 HTTP 헤더
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
