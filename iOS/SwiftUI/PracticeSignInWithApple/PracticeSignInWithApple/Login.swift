//
//  ContentView.swift
//  PracticeSignInWithApple
//
//  Created by 석민솔 on 2/5/24.
//

import SwiftUI
import AuthenticationServices


struct Login: View {
    @State private var isLoginSucceed = false
    
    var body: some View {
        Text("애플로그인 성공하고 만다")
        
        // 로그인 버튼
        SignInWithAppleButton { (request) in
            
            // requesting parameters from apple login
            request.requestedScopes = [.email]
            
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
                let userEmail = credential.email
                
                
                print("userID: \(userIdentifier)")
                print("user email: \(userEmail)")
                
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
        .signInWithAppleButtonStyle(.black)
        .frame(height: 55)
        .clipShape(Capsule())
        .padding(.horizontal)
        
        if (isLoginSucceed) {
            Text("성공했따!!!")
                .animation(.bouncy)
        }
    }
}

#Preview {
    Login()
}
