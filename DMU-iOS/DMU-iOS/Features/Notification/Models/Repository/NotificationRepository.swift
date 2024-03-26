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

    func postUpdateKeyword(tokens: [String], topic: [String], completion: @escaping (Result<Bool, Error>) -> Void) {
        provider.request(.postUpdateKeyword(tokens: tokens, topic: topic)) { result in
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
    
    func postDeleteKeyword(tokens: [String], topic: [String], completion: @escaping (Result<Bool, Error>) -> Void) {
        provider.request(.postDeleteKeyword(tokens: tokens, topic: topic)) { result in
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
    
    func postUpdateDepartment(tokens: [String], department: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        provider.request(.postUpdateDepartment(tokens: tokens, department: department)) { result in
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
    
    func postDeleteDepartment(tokens: [String], department: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        provider.request(.postDeleteDepartment(tokens: tokens, department: department)) { result in
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
