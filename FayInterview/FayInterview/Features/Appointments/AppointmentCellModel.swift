//
//  AppointmentCellModel.swift
//  FayInterview
//
//  Created by Shawna MacNabb on 6/14/25.
//

import Foundation

class AppointmentCellModel {
    let appointment: Appointment

    var appointmentTitle: String {
        return "\(appointment.appointmentType.rawValue) with Taylor Palmer, RD"
    }

    var appointmentDuration: String {
        return formatTimeRange(start: appointment.start, end: appointment.end)
    }

    init(appointment: Appointment) {
        self.appointment = appointment
    }

    private func formatTimeRange(start: Date, end: Date) -> String {
        let timeZone = TimeZone.current
        let abbreviation = timeZone.abbreviation() ?? ""

        let formatter = Date.FormatStyle()
            .hour(.defaultDigits(amPM: .abbreviated))
            .minute(.twoDigits)

        let startString = start.formatted(formatter)
        let endString = end.formatted(formatter)

        return "\(startString) – \(endString) (\(abbreviation))"
    }

    func onJoinZoomTap() {
        // open the URL here, I generally have a modifier that observes a `url`
    }
}
