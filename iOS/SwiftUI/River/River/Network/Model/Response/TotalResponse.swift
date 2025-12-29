//
//  TotalResponse.swift
//  PracticeURLSession
//
//  Created by 석민솔 on 8/20/25.
//

import Foundation

struct TotalResponse: Decodable {
    let listRiverStageService: RiverStageServiceResponse
    
    enum CodingKeys: String, CodingKey {
        case listRiverStageService = "ListRiverStageService"
    }
}

struct RiverStageServiceResponse: Decodable {
    let list_total_count: Int
    let result: ResultResponse
    let row: [RiverResponse]
    
    enum CodingKeys: String, CodingKey {
        case list_total_count
        case result = "RESULT"
        case row
    }
}
