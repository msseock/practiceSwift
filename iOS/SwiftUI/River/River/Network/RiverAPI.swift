//
//  RiverAPI.swift
//  PracticeURLSession
//
//  Created by 석민솔 on 8/20/25.
//

import Foundation

enum RiverAPI {
    case getAllData
    case getsingleData(riverName: String)
    case getError
    
    var endIndex: Int {
        switch self {
        case .getAllData:
            21
        case .getsingleData:
            1
        case .getError:
            10000
        }
    }
    
    var riverName: String? {
        switch self {
        case .getsingleData(let riverName):
            riverName
        default: nil
        }
    }
        
    var method: String {
        return "GET"
    }
}

extension RiverAPI {
    var urlRequest: URLRequest? {
        guard let url = RiverDataRequestInfo(endIndex: endIndex, riverName: riverName).url else { return nil }
        
        // ✅ URLRequest 생성 및 설정
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        // HTTP/1.1 강제 사용을 위한 헤더
        request.setValue("close", forHTTPHeaderField: "Connection")
        request.setValue("iOS-App/1.0", forHTTPHeaderField: "User-Agent")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // 캐시 비활성화
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        return request
    }
}
