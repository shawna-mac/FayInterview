//
//  SignInViewModel.swift
//  FayInterview
//
//  Created by Shawna MacNabb on 6/13/25.
//

import Combine
import Foundation
import SwiftUI

final class SignInViewModel: ObservableObject {

    @Published var username: String = ""
    @Published var password: String = ""
    @Published var usernameError: String?
    @Published var passwordError: String?
    @Published var toast: Toast?
    @Published var isLoading: Bool = false

    private let authService: AuthProtocol
    private var cancellables = Set<AnyCancellable>()
    private let onSuccessfulLogin: () -> Void

    init(
        authService: AuthProtocol = AuthService(),
        onSuccessfulLogin: @escaping () -> Void
    ) {
        self.authService = authService
        self.onSuccessfulLogin = onSuccessfulLogin

        setupObservers()
    }

    private func setupObservers() {
        // clean up errors if there are any and the user has began to type in the field
        $username.dropFirst().sink { [weak self] newValue in
            guard let self else { return }
            if usernameError != nil {
                usernameError = nil
            }
        }.store(in: &cancellables)

        $password.dropFirst().sink { [weak self] newValue in
            guard let self else { return }
            if passwordError != nil {
                passwordError = nil
            }
        }.store(in: &cancellables)
    }

    func onSignInTap() {
        var hasError: Bool = false
        if username.isEmpty {
            hasError = true
            usernameError = "Please enter username"
        }
        // normally I would check if the email is valid, but the doc shows a username to login and not email

        if password.isEmpty {
            hasError = true
            passwordError = "Please enter password"
        }
        // I don't know what the password rules are to check and make sure it's semi valid before sending off to service
        // Example: if we don't allow certain characters, I could see if they exist first 

        if hasError {
            return
        }

        isLoading = true

        Task { @MainActor in
            do {
                try await authService.signIn(email: username, password: password)
                isLoading = false
                onSuccessfulLogin()
            } catch {
                toast = Toast(type: .error, title: "Something went wrong while logging in")
                isLoading = false
            }
        }
    }
}
