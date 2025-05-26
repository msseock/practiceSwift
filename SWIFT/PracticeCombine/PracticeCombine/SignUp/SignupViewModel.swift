//
//  SignupViewModel.swift
//  PracticeCombine
//
//  Created by 석민솔 on 5/26/25.
//

import Foundation
import Combine
import UIKit

class SignupViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var passwordAgain: String = ""

    // MARK: - UI Binding Outputs
    @Published var isSignupButtonEnabled: Bool = false
    @Published var usernameValidationColor: UIColor = .systemGray
    @Published var passwordValidationColor: UIColor = .systemGray

    // MARK: - Internal
    private var cancellables = Set<AnyCancellable>()
    private let minimumPasswordLength = 6

    // MARK: - Init
    init() {
        subscribeValidatedUserName()
        subscribeValidatedPassword()
        subscribeValidatedCredentials()
    }

    // MARK: - Validation Publishers
    var validatedPassword: AnyPublisher<String?, Never> {
        return $password
            .combineLatest($passwordAgain)
            .map { [weak self] password, passwordAgain in
                guard let self else { return nil }
                guard password == passwordAgain, password.count >= self.minimumPasswordLength else { return nil }
                return password
            }
            .eraseToAnyPublisher()
    }

    var validatedUsername: AnyPublisher<String?, Never> {
        return $username
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { [weak self] username in
                Future { promise in
                    self?.userNameAvailable(username) { available in
                        promise(.success(available ? username : nil))
                    }
                }
            }
            .eraseToAnyPublisher()
    }

    var validatedCredentials: AnyPublisher<(String, String)?, Never> {
        return validatedUsername
            .combineLatest(validatedPassword)
            .map { username, password in
                guard let username, let password else { return nil }
                return (username, password)
            }
            .eraseToAnyPublisher()
    }

    // MARK: - Combine Subscriptions
    private func subscribeValidatedUserName() {
        validatedUsername
            .receive(on: RunLoop.main)
            .sink { [weak self] validatedUsername in
                self?.usernameValidationColor = (validatedUsername == nil) ? .systemGray : .systemGreen
            }
            .store(in: &cancellables)
    }

    private func subscribeValidatedPassword() {
        validatedPassword
            .receive(on: RunLoop.main)
            .sink { [weak self] validatedPassword in
                self?.passwordValidationColor = (validatedPassword == nil) ? .systemGray : .systemGreen
            }
            .store(in: &cancellables)
    }

    private func subscribeValidatedCredentials() {
        validatedCredentials
            .map { $0 != nil }
            .receive(on: RunLoop.main)
            .assign(to: &$isSignupButtonEnabled)
    }

    // MARK: - Dummy Server Validation
    private func userNameAvailable(_ username: String, completion: @escaping (Bool) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.3) {
            // Fake logic: usernames longer than 3 are available
            completion(username.count > 3)
        }
    }
}
