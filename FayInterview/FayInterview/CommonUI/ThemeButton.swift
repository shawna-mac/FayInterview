//
//  ThemeButton.swift
//  FayInterview
//
//  Created by Shawna MacNabb on 6/14/25.
//

import SwiftUI

struct ThemeButton: View {

    private let title: String
    private let icon: String?
    @Binding private var isLoading: Bool

    private let action: () -> Void

    init(
        title: String,
        icon: String? = nil,
        isLoading: Binding<Bool>? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        // this is so isLoading defaults to nil and I don't have to have the binding everywhere
        self._isLoading = isLoading ?? Binding(get: { false }, set: { _ in })
        self.action = action
    }

    var body: some View {
        Button(action: action, label: {
            Group {
                if isLoading {
                    ProgressView()
                } else {
                    HStack(spacing: 12) {
                        if let icon {
                            Image(systemName: icon)
                                .renderingMode(.template)
                                .foregroundStyle(.white)
                        }
                        Text(.body(text: title, color: .white))
                    }
                }
            }
            .padding(.all, 12)
        })
        .disabled(isLoading)
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color.primaryAccent)
        .cornerRadius(8)
    }
}
