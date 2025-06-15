//
//  AppCoordinator.swift
//  FayInterview
//
//  Created by Shawna MacNabb on 6/14/25.
//

import SwiftUI

class AppCoordinator: ObservableObject {

    static let shared = AppCoordinator()

    @Published var appScreen: AppScreen = .auth

    // top level app screens
    enum AppScreen {
        case auth
        case main
    }

    func show(_ appScreen: AppScreen) {
        withAnimation {
            self.appScreen = appScreen
        }
    }

    func handle401() {
        KeychainHelper.delete(forKey: "jwt_token")
        show(.auth)
    }

    func determineInitialScreen() {
        // if there is a JWT Token they are logged in
        // normally there is an endpoint to refresh this token but since there isn't
        // i'm going to wait to get a 401 from subsequent network calls and then make them login again
        if KeychainHelper.get(forKey: "jwt_token") != nil {
            show(.main)
        } else {
            show(.auth)
        }
    }
}
