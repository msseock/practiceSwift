//
//  SignupView.swift
//  PracticeCombine
//
//  Created by 석민솔 on 5/26/25.
//

import SwiftUI
import Combine

struct SignupView: View {
    @StateObject private var viewModel = SignupViewModel()

    var body: some View {
        VStack(spacing: 16) {
            Text("Wizard School Signup")
            
            HStack {
                Image(systemName: "person.circle")
                    .font(.title)
                    .foregroundStyle(Color(viewModel.usernameValidationColor))
                
                TextField("Wizard name", text: $viewModel.username)
                    .textFieldStyle(.roundedBorder)
            }

            HStack {
                Image(systemName: "lock.circle")
                    .font(.title)
                    .foregroundStyle(Color(viewModel.passwordValidationColor))

                TextField("Password", text: $viewModel.password)
                    .textFieldStyle(.roundedBorder)
            }

            HStack {
                Image(systemName: "lock.circle")
                    .font(.title)
                    .foregroundStyle(Color(viewModel.passwordValidationColor))
                
                TextField("Repeat Password", text: $viewModel.passwordAgain)
                    .textFieldStyle(.roundedBorder)
            }

            Button("Sign Up") {
                print("Signed up!")
            }
            .disabled(!viewModel.isSignupButtonEnabled)
            .frame(maxWidth: .infinity)
            .padding()
            .background(viewModel.isSignupButtonEnabled ? Color.green : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
}

#Preview {
    SignupView()
}
