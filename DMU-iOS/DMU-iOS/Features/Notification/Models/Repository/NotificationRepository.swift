//
//  NotificationRepository.swift
//  DMU-iOS
//
//  Created by 이예빈 on 3/26/24.
//

import Foundation

import Moya

class NotificationRepository {
    let provider = MoyaProvider<APIService>()
    
    func postInitToken(token: String, department: String, topics: [String], completion: @escaping (Result<Bool, Error>) -> Void) {
        provider.request(.postInitToken(token: token, department: department, topics: topics)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedResponse = try JSONDecoder().decode(NotificationResponseDTO.self, from: response.data)
                    if decodedResponse.success {
                        completion(.success(true))
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : decodedResponse.message ?? "Unknown error"])
                        completion(.failure(error))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func postUpdateKeyword(token: String, topics: [String], completion: @escaping (Result<Bool, Error>) -> Void) {
        provider.request(.postUpdateKeyword(token: token, topics: topics)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedResponse = try JSONDecoder().decode(NotificationResponseDTO.self, from: response.data)
                    if decodedResponse.success {
                        completion(.success(true))
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : decodedResponse.message ?? "Unknown error"])
                        completion(.failure(error))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func postDeleteKeyword(token: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        provider.request(.postDeleteKeyword(token: token)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedResponse = try JSONDecoder().decode(NotificationResponseDTO.self, from: response.data)
                    if decodedResponse.success {
                        completion(.success(true))
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : decodedResponse.message ?? "Unknown error"])
                        completion(.failure(error))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func postUpdateDepartment(token: String, department: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        provider.request(.postUpdateDepartment(token: token, department: department)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedResponse = try JSONDecoder().decode(NotificationResponseDTO.self, from: response.data)
                    if decodedResponse.success {
                        completion(.success(true))
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : decodedResponse.message ?? "Unknown error"])
                        completion(.failure(error))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func postDeleteDepartment(token: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        provider.request(.postDeleteDepartment(token: token)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedResponse = try JSONDecoder().decode(NotificationResponseDTO.self, from: response.data)
                    if decodedResponse.success {
                        completion(.success(true))
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : decodedResponse.message ?? "Unknown error"])
                        completion(.failure(error))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
