//
//  NetworkResult.swift
//  PracticeURLSession
//
//  Created by 석민솔 on 8/20/25.
//

import Foundation

/// 에러
enum APIResult: LocalizedError {
    case success // INFO-000
    case missingRequiredValue // ERROR-300
    case invalidAuthKey // INFO-100
    case invalidFileType // ERROR-301
    case serviceNotFound // ERROR-310
    case invalidStartIndex // ERROR-331
    case invalidEndIndex // ERROR-332
    case invalidIndexType // ERROR-333
    case startIndexGreaterThanEndIndex // ERROR-334
    case sampleDataExceedsLimit // ERROR-335
    case dataRequestExceedsLimit // ERROR-336
    case serverError // ERROR-500
    case databaseConnectionError // ERROR-600
    case sqlError // ERROR-601
    case noDataFound // INFO-200
    
    var errorDescription: String? {
        switch self {
        case .success:
            return "정상 처리되었습니다"
        case .missingRequiredValue:
            return "필수 값이 누락되어 있습니다. 요청인자를 참고 하십시오."
        case .invalidAuthKey:
            return "인증키가 유효하지 않습니다. 인증키가 없는 경우, 열린 데이터 광장 홈페이지에서 인증키를 신청하십시오."
        case .invalidFileType:
            return "파일타입 값이 누락 혹은 유효하지 않습니다. 요청인자 중 TYPE을 확인하십시오."
        case .serviceNotFound:
            return "해당하는 서비스를 찾을 수 없습니다. 요청인자 중 SERVICE를 확인하십시오."
        case .invalidStartIndex:
            return "요청시작위치 값을 확인하십시오. 요청인자 중 START_INDEX를 확인하십시오."
        case .invalidEndIndex:
            return "요청종료위치 값을 확인하십시오. 요청인자 중 END_INDEX를 확인하십시오."
        case .invalidIndexType:
            return "요청위치 값의 타입이 유효하지 않습니다. 요청위치 값은 정수를 입력하세요."
        case .startIndexGreaterThanEndIndex:
            return "요청종료위치 보다 요청시작위치가 더 큽니다. 요청시작조회건수는 정수를 입력하세요."
        case .sampleDataExceedsLimit:
            return "샘플데이터(샘플키:sample) 는 한번에 최대 5건을 넘을 수 없습니다. 요청시작위치와 요청종료위치 값은 1 ~ 5 사이만 가능합니다."
        case .dataRequestExceedsLimit:
            return "데이터요청은 한번에 최대 1000건을 넘을 수 없습니다. 요청종료위치에서 요청시작위치를 뺀 값이 1000을 넘지 않도록 수정하세요."
        case .serverError:
            return "서버 오류입니다. 지속적으로 발생시 열린 데이터 광장으로 문의(Q&A) 바랍니다."
        case .databaseConnectionError:
            return "데이터베이스 연결 오류입니다. 지속적으로 발생시 열린 데이터 광장으로 문의(Q&A) 바랍니다."
        case .sqlError:
            return "SQL 문장 오류 입니다. 지속적으로 발생시 열린 데이터 광장으로 문의(Q&A) 바랍니다."
        case .noDataFound:
            return "해당하는 데이터가 없습니다."
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .missingRequiredValue:
            return "요청 파라미터를 확인하고 필수 값을 추가해주세요."
        case .invalidAuthKey:
            return "열린 데이터 광장에서 유효한 인증키를 발급받아주세요."
        case .invalidFileType:
            return "TYPE 파라미터 값을 확인해주세요."
        case .serviceNotFound:
            return "SERVICE 파라미터 값을 확인해주세요."
        case .invalidStartIndex:
            return "START_INDEX 값을 올바른 형식으로 입력해주세요."
        case .invalidEndIndex:
            return "END_INDEX 값을 올바른 형식으로 입력해주세요."
        case .invalidIndexType:
            return "요청 위치 값을 정수로 입력해주세요."
        case .startIndexGreaterThanEndIndex:
            return "요청 시작위치가 종료위치보다 작도록 수정해주세요."
        case .sampleDataExceedsLimit:
            return "샘플 데이터 요청 시 1~5건 사이로 제한해주세요."
        case .dataRequestExceedsLimit:
            return "한 번에 최대 1000건까지만 요청해주세요."
        case .serverError, .databaseConnectionError, .sqlError:
            return "잠시 후 다시 시도하거나 열린 데이터 광장에 문의해주세요."
        default:
            return nil
        }
    }
    
    // 에러 코드와 매핑하는 편의 이니셜라이저
    init?(code: String) {
        switch code {
        case "INFO-000": self = .success
        case "ERROR-300": self = .missingRequiredValue
        case "INFO-100": self = .invalidAuthKey
        case "ERROR-301": self = .invalidFileType
        case "ERROR-310": self = .serviceNotFound
        case "ERROR-331": self = .invalidStartIndex
        case "ERROR-332": self = .invalidEndIndex
        case "ERROR-333": self = .invalidIndexType
        case "ERROR-334": self = .startIndexGreaterThanEndIndex
        case "ERROR-335": self = .sampleDataExceedsLimit
        case "ERROR-336": self = .dataRequestExceedsLimit
        case "ERROR-500": self = .serverError
        case "ERROR-600": self = .databaseConnectionError
        case "ERROR-601": self = .sqlError
        case "INFO-200": self = .noDataFound
        default: return nil
        }
    }
}

enum NetworkError: LocalizedError {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "유효하지 않은 URL입니다."
        case .noData:
            return "데이터를 받지 못했습니다."
        case .decodingError:
            return "데이터 디코딩에 실패했습니다."
        case .serverError(let statusCode):
            return "서버 에러: \(statusCode)"
        case .unknown(let error):
            return "알 수 없는 에러: \(error.localizedDescription)"
        }
    }
}
