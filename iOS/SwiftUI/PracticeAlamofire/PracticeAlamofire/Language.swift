//
//  Language.swift
//  PracticeAlamofire
//
//  Created by 석민솔 on 7/20/24.
//

import Foundation

/// 한국어, 베트남어, 구분하는 언어 코드
enum LanguageCode {
    case ko
    case viet
}

/// 베트남어, 한국어, 중국어 구별
func distinguishLanguage(_ text: String) -> LanguageCode {
    // 한국어, 중국어, 베트남어에 해당하는 유니코드 범위 및 세트 정의
    let koreanRange = 0xAC00...0xD7AF
    let vietnameseDiacritics: Set<Character> = ["à", "á", "ả", "ã", "ạ", "ă", "ằ", "ắ", "ẳ", "ẵ", "ặ", "â", "ầ", "ấ", "ẩ", "ẫ", "ậ", "è", "é", "ẻ", "ẽ", "ẹ", "ê", "ề", "ế", "ể", "ễ", "ệ", "ì", "í", "ỉ", "ĩ", "ị", "ò", "ó", "ỏ", "õ", "ọ", "ô", "ồ", "ố", "ổ", "ỗ", "ộ", "ơ", "ờ", "ớ", "ở", "ỡ", "ợ", "ù", "ú", "ủ", "ũ", "ụ", "ư", "ừ", "ứ", "ử", "ữ", "ự", "ỳ", "ý", "ỷ", "ỹ", "ỵ", "đ"]

    for scalar in text.unicodeScalars {
        if koreanRange.contains(Int(scalar.value)) {
            return .ko
        } else if vietnameseDiacritics.contains(Character(scalar)) {
            return .viet
        }
    }

    // 언어를 판별할 수 없는 경우 한국어로 기본값 반환
    return .ko
}

/// 언어 코드에 맞는 문자열 반환
func languageCode(for lang: LanguageCode) -> String {
    switch lang {
    case .ko:
        return "ko"
    case .viet:
        return "vi"
    }
}

func switchLanguage(target: String) -> String {
    if target == "vi" {
        return "ko"
    } else if target == "ko" {
        return "vi"
    } else { return "ko" }
}

