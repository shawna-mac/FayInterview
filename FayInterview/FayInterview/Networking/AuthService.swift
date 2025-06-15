//
//  AuthService.swift
//  FayInterview
//
//  Created by Shawna MacNabb on 6/13/25.
//

protocol AuthProtocol {
    func signIn(email: String, password: String) async throws
}

struct AuthService: AuthProtocol {
    func signIn(email: String, password: String) async throws {
        let authRequest = AuthRequest(username: email, password: password)
        let response = try await Request.performRequest(
            AuthResponse.self,
            endpoint: Endpoints.AuthService.signin,
            method: .post,
            body: authRequest
        )

        // JWT Token should be saved securely
        KeychainHelper.set(response.token, forKey: "jwt_token")
    }
}
