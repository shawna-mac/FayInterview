//
//  ContentView.swift
//  FayInterview
//
//  Created by Shawna MacNabb on 6/13/25.
//

import SwiftUI

struct ContentView: View {

    @StateObject var appCoordinator = AppCoordinator()

    var body: some View {
        VStack {
            switch appCoordinator.appScreen {
            case .auth:
                NavigationStack {
                    SignInView(
                        viewModel: SignInViewModel(
                            onSuccessfulLogin: {
                                appCoordinator.show(.main)
                            }
                        )
                    )
                }
            case .main:
                NavigationStack {
                    AppointmentsView(viewModel: AppointmentsViewModel())
                }
            }
        }
        // load once, no need to keep calling onappear
        .onLoad {
            appCoordinator.determineInitialScreen()
        }
    }
}

#Preview {
    ContentView()
}
