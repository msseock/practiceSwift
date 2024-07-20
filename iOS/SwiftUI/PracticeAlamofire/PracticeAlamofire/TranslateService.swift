//
//  TranslateService.swift
//  PracticeAlamofire
//
//  Created by 석민솔 on 7/19/24.
//

import Alamofire
import Foundation
import SwiftUI

struct TranslateService {
    
    func translateText() {
        let text = "우리 가족은 부모님, 여동생, 저까지 4명이에요. 아버지는 선생님, 어머니는 주부, 여동생은 중학생이에요."
        
        // 언어 감지, 반환: from 언어와 to 언어
        let languageSet = detectAndSwitchLanguage(text: text)
               
        // 번역 요청할 URL 생성
        let finalURL = makeURL(from: languageSet.from, to: languageSet.to, text: text)
        
        // Alamofire를 사용한 HTTP 요청
        fetchTranslations(url: finalURL)
    }
    
    func fetchTranslations(url: String) {
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                
                if let jsonArray = value as? [Any],
                   let firstElement = jsonArray.first as? [Any] {
                    
                    let firstTexts = firstElement.compactMap { item in
                        (item as? [Any])?.first as? String  // item을 배열로 캐스팅 후 첫 번째 요소 반환
                    }
                    
                    let translatedText = firstTexts.joined()
                    print("translatedText: \(translatedText)")

                } else {
                    print("Failed to parse the translation response.")
                }
            case .failure(let error):
                print("Error while fetching data: \(error)")
            }
        }
    }
    
    func detectAndSwitchLanguage(text: String) -> (from: String, to: String) {
        // 언어감지
        let langCode = distinguishLanguage(text)
        
        // 언어코드 string값으로 바꾸기
        let selected_language = languageCode(for: langCode)
        
        // 감지된 언어 바탕으로 번역할 언어도 찾기
        let target_language = switchLanguage(target: selected_language)
        
        return (from: selected_language, to: target_language)
    }
    
    func makeURL(from selected_language: String, to target_language: String, text: String) -> String {
        // URL 인코딩
        let baseGoogleUrl = "https://translate.googleapis.com/translate_a/single?client=gtx"
        let query = "&sl=\(selected_language)&tl=\(target_language)&dt=t&q=\(text)"
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        // 최종 URL 생성
        return baseGoogleUrl + encodedQuery
    }
}
