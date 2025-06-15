//
//  Toast.swift
//  FayInterview
//
//  Created by Shawna MacNabb on 6/13/25.
//

import Combine
import SwiftUI

extension View {
    func toast(_ toast: Binding<Toast?>) -> some View {
        self.modifier(
            ToastViewOverlay(toast: toast)
        )
    }
}

struct Toast: Sendable {
    let type: ToastType
    let title: AttributedString

    init(
        type: ToastType,
        title: String
    ) {
        self.type = type
        self.title = .body(text: title)
    }
}

enum ToastType: Sendable {
    case info
    case success
    case error

    var backgroundColor: UIColor {
        switch self {
        case .info, .success:
            return .green
        case .error:
            return .red
        }
    }
}

struct ToastView: View {
    @Binding var toast: Toast?
    @State var timer: Publishers.Autoconnect<Timer.TimerPublisher>

    var body: some View {
        if let toast {
            HStack(alignment: .top, spacing: 10) {
                Text(toast.title)
                    .foregroundColor(.gray)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, minHeight: 40, alignment: .leading)
                Spacer(minLength: 1)
            }
            .foregroundColor(.white)
            .padding([.top, .bottom], 10)
            .padding(.leading, 16)
            .padding(.trailing, 5)
            .background(Color(toast.type.backgroundColor))
            .cornerRadius(16)
            .frame(maxWidth: 400, alignment: .center)
            .onReceive(timer) { _ in
                self.dismiss()
            }
            .onTapGesture {
                self.dismiss()
            }
            .transition(.move(edge: .bottom))
        }
    }

    func dismiss() {
        withAnimation {
            toast = nil
        }
    }
}

struct ToastViewOverlay: ViewModifier {
    let toast: Binding<Toast?>

    func body(content: Content) -> some View {
        content.overlay(toast.wrappedValue != nil ? toastView : nil)
    }

    var toastView: some View {
        VStack {
            Spacer()
            ToastView(toast: toast, timer: Timer.publish(every: 5.0, on: .main, in: .common).autoconnect())
                .padding([.leading, .trailing], 18)
                .padding(.bottom, 80)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}
