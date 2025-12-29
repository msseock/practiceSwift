//
//  RiverDataRequestInfo.swift
//  PracticeURLSession
//
//  Created by 석민솔 on 8/20/25.
//

import Foundation

struct RiverDataRequestInfo {
    init(endIndex: Int, riverName: String? = nil) {
        self.endIndex = endIndex
        self.riverName = riverName
    }
    
    // ✅ 확실히 HTTP로 설정
    let baseURL: String = "http://openapi.seoul.go.kr:8088"
    let key: String = "66684b7a4e6d73733433457877736c"
    let type: String = "json"
    let service: String = "ListRiverStageService"
    let startIndex: Int = 1
    let endIndex: Int
    let riverName: String?
    
    var url: URL? {
        var urlString = "\(baseURL)/\(key)/\(type)/\(service)/\(startIndex)/\(endIndex)"
        
        if let riverName {
            urlString += "/\(riverName)"
        }
        
        return URL(string: urlString)
    }
}
