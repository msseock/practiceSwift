//
//  ResultResponse.swift
//  PracticeURLSession
//
//  Created by 석민솔 on 8/20/25.
//

import Foundation

struct ResultResponse: Decodable {
    let code: String
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case code = "CODE"
        case message = "MESSAGE"
    }
}
