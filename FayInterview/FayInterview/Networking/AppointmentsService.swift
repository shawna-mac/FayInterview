//
//  AppointmentsService.swift
//  FayInterview
//
//  Created by Shawna MacNabb on 6/13/25.
//

protocol AppointmentsProvider {
    func fetchAppointments() async throws -> [Appointment]
}

struct AppointmentsService: AppointmentsProvider {
    func fetchAppointments() async throws -> [Appointment] {
        let appointmentsContainer = try await Request.performRequest(
            AppointmentsResponse.self,
            endpoint: Endpoints.AppointmentsService.appointments
        )
        return appointmentsContainer.appointments
    }
}
