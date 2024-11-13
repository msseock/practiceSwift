//
//  ContentView.swift
//  PracticeSignInWithApple
//
//  Created by 석민솔 on 2/5/24.
//

import SwiftUI
import AuthenticationServices


struct LoginView: View {
    @State private var isLoginSucceed = false
    
    var body: some View {
        Text("애플로그인 성공하고 만다")
        
        // 로그인 버튼
        SignInWithAppleButton { (request) in
            
        } onCompletion: { (result) in
            
            // getting error or success
            
            switch result {
            case .success(let user):
                print("success")
                isLoginSucceed = true
                // do login
                guard let credential = user.credential as? ASAuthorizationAppleIDCredential else {
                    print("error")
                    return
                }
                
                let userIdentifier = credential.user
                let idToken = credential.identityToken // 서버에 보내줄 토큰
                
                // 값 저장하기
                UserDefaults.standard.set(userIdentifier, forKey: "appleUID")

                // 값 불러오기
                let appleIdentifier = UserDefaults.standard.string(forKey: "appleUID")
                
                print("userID: \(String(describing: appleIdentifier))")
                print("user idToken: \(String(decoding: idToken!, as: UTF8.self))")
                
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
        .signInWithAppleButtonStyle(.black)
        .frame(height: 55)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
        
        if (isLoginSucceed) {
            Text("성공했따!!!")
                .animation(.bouncy)
        }
    }
}

#Preview {
    LoginView()
}
