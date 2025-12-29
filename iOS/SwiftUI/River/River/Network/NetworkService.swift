//
//  NetworkService.swift
//  PracticeURLSession
//
//  Created by 석민솔 on 8/20/25.
//

import Foundation

// MARK: Network Service
/// 실제 네트워킹을 수행하는 서비스 클래스
class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    private lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
                
        // HTTP/2, HTTP/3 비활성화
        config.httpMaximumConnectionsPerHost = 1
        
        return URLSession(configuration: config)
    }()
    
    private let decoder = JSONDecoder()
    
    /// Async/Await 버전의 네트워킹 함수
    func requestAsync<T: Decodable>(_ endpoint: RiverAPI, type: T.Type) async throws -> T {
        guard let request = endpoint.urlRequest else {
            throw NetworkError.invalidURL
        }
        
        print("🌐 Request URL: \(request.url?.absoluteString ?? "nil")")
        print("🌐 Request Method: \(request.httpMethod ?? "nil")")
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown(URLError(.badServerResponse))
        }
        
        print("📡 Response Status: \(httpResponse.statusCode)")
        
        // ✅ 응답 데이터 확인용 로그 추가
        if let responseString = String(data: data, encoding: .utf8) {
            print("📄 Raw Response:")
            print(responseString)
            print("📄 Response End")
        } else {
            print("🚨 Cannot convert response to string")
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
        
        // ✅ 데이터가 비어있는지 확인
        guard !data.isEmpty else {
            print("🚨 Empty response data")
            throw NetworkError.noData
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("🚨 Decoding Error: \(error)")
            
            // ✅ 디코딩 에러 상세 정보
            if let decodingError = error as? DecodingError {
                switch decodingError {
                case .dataCorrupted(let context):
                    print("🔍 Data corrupted: \(context)")
                    print("🔍 Context description: \(context.debugDescription)")
                    if let underlyingError = context.underlyingError {
                        print("🔍 Underlying error: \(underlyingError)")
                    }
                case .keyNotFound(let key, let context):
                    print("🔍 Key '\(key)' not found: \(context)")
                case .typeMismatch(let type, let context):
                    print("🔍 Type '\(type)' mismatch: \(context)")
                case .valueNotFound(let value, let context):
                    print("🔍 Value '\(value)' not found: \(context)")
                @unknown default:
                    print("🔍 Unknown decoding error")
                }
            }
            
            throw NetworkError.decodingError
        }
    }
}
