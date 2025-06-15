//
//  Appointment.swift
//  FayInterview
//
//  Created by Shawna MacNabb on 6/13/25.
//

import Foundation

struct Appointment: Identifiable, Codable {
    var id: String { appointmentId }
    let appointmentId: String
    let patientId: String
    let providerId: String
    let status: AppointmentStatus
    let appointmentType: AppointmentType
    let start: Date
    let end: Date
    let durationInMinutes: Int
    let recurrenceType: RecurrenceType

    // for testing purposes, we can inject whatever is needed for testing
    static func mocked(
        appointmentId: String = UUID().uuidString,
        status: AppointmentStatus = .scheduled,
        appointmentType: AppointmentType = .followUp,
        durationInMinutes: Int = 60,
        recurrenceType: RecurrenceType = .weekly
    ) -> Appointment {
        return Appointment(
            appointmentId: appointmentId,
            patientId: "456",
            providerId: "789",
            status: status,
            appointmentType: appointmentType,
            start: Date(),
            end: Date().addingTimeInterval(60 * 60),
            durationInMinutes: 60,
            recurrenceType: recurrenceType
        )
    }
}
