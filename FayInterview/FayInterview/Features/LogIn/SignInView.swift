//
//  SignInView.swift
//  FayInterview
//
//  Created by Shawna MacNabb on 6/13/25.
//

import SwiftUI

struct SignInView: View {

    @StateObject var viewModel: SignInViewModel
    @FocusState private var focusedField: Field?

    enum Field: Hashable {
        case username
        case password
    }

    var body: some View {
        VStack(alignment: .leading) {
            header
            Group {
                Spacer()
                title
                usernameTextField
                passwordTextField
                signinButton
                Spacer()
            }
            .padding(.horizontal, 24)
        }
        .toast($viewModel.toast)
        .hideKeyboardOnTap()
        .background(Color.white) // locking light mode for now
    }

    private var header: some View {
        VStack(alignment: .leading) {
            Text(.title3(text: "Fay", fontWeight: .semibold, color: .gray))
                .padding(.vertical, 12)
                .padding(.horizontal, 24)
            Divider()
        }
    }

    private var title: some View {
        Text(.title2(text: "Log In", fontWeight: .bold))
            .padding(.bottom, 36)
    }

    private var usernameTextField: some View {
        ThemeTextField(
            text: $viewModel.username,
            placeholder: "Username",
            errorMessage: $viewModel.usernameError
        )
        .padding(.bottom, 16)
        .submitLabel(.next)
        .focused($focusedField, equals: .username)
        .onSubmit {
            focusedField = .password
        }
    }

    private var passwordTextField: some View {
        ThemeTextField(
            text: $viewModel.password,
            placeholder: "Password",
            errorMessage: $viewModel.passwordError,
            type: .password
        )
        .submitLabel(.return)
        .padding(.bottom, 48)
        .focused($focusedField, equals: .password)
        .onSubmit {
            focusedField = nil
            viewModel.onSignInTap()
        }
    }

    private var signinButton: some View {
        ThemeButton(
            title: "Sign In",
            isLoading: $viewModel.isLoading,
            action: viewModel.onSignInTap
        )
    }
}
