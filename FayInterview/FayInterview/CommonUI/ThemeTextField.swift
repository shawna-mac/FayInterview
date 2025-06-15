//
//  CustomTextField.swift
//  FayInterview
//
//  Created by Shawna MacNabb on 6/14/25.
//

import SwiftUI

enum TextFieldType {
    case plain
    case password
}

struct ThemeTextField: View {

    @Binding var text: String
    let placeholder: String
    @Binding var errorMessage: String?
    var type: TextFieldType = .plain

    var body: some View {
        VStack {
            Group {
                switch type {
                case .plain:
                    TextField(placeholder, text: $text)
                        .foregroundStyle(hasError ? .red : .black)
                case .password:
                    SecureField(placeholder, text: $text)
                        .foregroundStyle(hasError ? .red : .black)
                }
            }
            .autocorrectionDisabled()
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(hasError ? Color.red : Color.gray, lineWidth: 1)
            )

            if let errorMessage {
                Text(.body(text: errorMessage, color: .red))
                    .padding(.top, 16)
            }
        }
        .frame(maxWidth: .infinity)
    }

    private var hasError: Bool {
        return errorMessage != nil
    }
}
