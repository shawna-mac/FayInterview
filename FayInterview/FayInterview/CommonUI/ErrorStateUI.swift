//
//  ErrorStateUI.swift
//  FayInterview
//
//  Created by Shawna MacNabb on 6/13/25.
//

import SwiftUI

// reusable view to display an error state
public struct ErrorStateUI: View {

    private let retryAction: () async -> Void

    public init(retryAction: @escaping () async -> Void) {
        self.retryAction = retryAction
    }

    public var body: some View {
        VStack {
            Text(.title3(text: "Something went wrong"))
            Button(action: {
                Task {
                    await retryAction()
                }
            }, label: {
                Text("Retry")
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ErrorStateUI(retryAction: {})
}
