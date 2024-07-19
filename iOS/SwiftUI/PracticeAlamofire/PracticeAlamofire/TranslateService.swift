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
    
    func translateText(text: String) {
        print("your text: \(text)")
        
        // 언어감지
        let langCode = distinguishLanguage(text)
        
        // 언어코드 string값으로 바꾸기
        let selected_language = languageCode(for: langCode)
        
        // 감지된 언어 바탕으로 번역할 언어도 찾기
        let target_language = switchLanguage(target: selected_language)
        print("target_language: \(target_language)")
        
        // URL 인코딩
        let baseGoogleUrl = "https://translate.googleapis.com/translate_a/single?client=gtx"
        let query = "&sl=\(selected_language)&tl=\(target_language)&dt=t&q=\(text)"
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        // 최종 URL 생성
        let GoogleUrl = baseGoogleUrl + encodedQuery
        print("최종 url: \(GoogleUrl)")
        
        
        // Alamofire를 사용한 HTTP 요청
        AF.request(GoogleUrl).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let jsonArray = value as? [Any], 
                    let firstElement = jsonArray.first as? [Any],
                    let firstTranslation = firstElement.first as? [Any],
                    let translatedText = firstTranslation[0] as? String {
                    print("Translated Text: \(translatedText)")
                } else {
                    print("Failed to parse the translation response.")
                }
            case .failure(let error):
                print("Error while fetching data: \(error)")
            }
        }
    }
}
