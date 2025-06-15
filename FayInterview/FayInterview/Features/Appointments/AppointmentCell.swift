//
//  AppointmentCell.swift
//  FayInterview
//
//  Created by Shawna MacNabb on 6/14/25.
//

import SwiftUI

struct AppointmentCell: View {

    let viewModel: AppointmentCellModel
    @State var isExpanded: Bool = false

    var body: some View {
        Button(action: {
            withAnimation {
                isExpanded.toggle()
            }
        }, label: {
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    details
                    if isExpanded {
                        zoomButton
                    }
                }
                .padding(.all, 12)
                Spacer()
            }
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
        })
        .frame(maxWidth: .infinity)
        .buttonStyle(.plain)
        .padding(.horizontal, 24)
    }

    private var details: some View {
        HStack {
            calendar
            VStack(alignment: .leading) {
                Text(.body(text: viewModel.appointmentTitle, fontWeight: .bold))
                    .padding(.bottom, 8)
                Text(.body2(text: viewModel.appointmentDuration))
                HStack(spacing: 8) {
                    Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90.circle")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(.black)
                        .frame(width: 16, height: 16)
                    Text(.body2(text: viewModel.appointment.recurrenceType.rawValue))
                }
            }
        }
    }

    private var calendar: some View {
        VStack(spacing: 0) {
            Text(.body2(text: viewModel.appointment.start.monthString, fontWeight: .bold, color: Color.primaryAccent))
                .padding(12)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color.secondaryAccent.opacity(0.4))

            Text(.body(text: viewModel.appointment.start.dayString, fontWeight: .bold))
                .padding(12)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color.secondaryAccent.opacity(0.1))
        }
        .fixedSize(horizontal: true, vertical: false)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    private var zoomButton: some View {
        ThemeButton(title: "Join Zoom", icon: "video", action: viewModel.onJoinZoomTap)
    }
}
