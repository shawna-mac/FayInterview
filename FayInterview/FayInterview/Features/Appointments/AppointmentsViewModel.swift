//
//  AppointmentsViewModel.swift
//  FayInterview
//
//  Created by Shawna MacNabb on 6/13/25.
//

import Foundation
import SwiftUI

final class AppointmentsViewModel: ObservableObject {

    @Published var screenState: ViewState = .loading
    @Published var selectedTab: MenuTab = .upcoming

    private let appointmentService: AppointmentsProvider
    
    private(set) var upcomingAppointments = [Appointment]()
    private(set) var pastAppointments = [Appointment]()

    enum MenuTab: String, Identifiable, CaseIterable {
        var id: Self { self }
        case upcoming = "Upcoming"
        case past = "Past"
    }

    init(
        appointmentService: AppointmentsProvider = AppointmentsService()
    ) {
        self.appointmentService = appointmentService
    }

    func retry() {
        upcomingAppointments = []
        pastAppointments = []
        updateScreenState(.loading)
        loadData()
    }

    func loadData() {
        Task { @MainActor in
            do {
                let appointments = try await appointmentService.fetchAppointments()
                upcomingAppointments = appointments.filter { !$0.start.isInThePast}
                pastAppointments = appointments.filter { $0.start.isInThePast }

                updateScreenState(.loaded)
            } catch {
                updateScreenState(.error)
            }
        }
    }

    func updateScreenState(_ state: ViewState) {
        withAnimation {
            screenState = state
        }
    }

    func getDataForSelectedTab() -> [Appointment] {
        switch selectedTab {
        case .upcoming:
            if screenState == .loading {
                return mockLoadingData()
            }
            return upcomingAppointments
        case .past:
            if screenState == .loading {
                return mockLoadingData()
            }
            return pastAppointments
        }
    }

    func isEmpty() -> Bool {
        switch selectedTab {
        case .upcoming:
            return upcomingAppointments.isEmpty
        case .past:
            return pastAppointments.isEmpty
        }
    }

    // Shimmer loader needs some fake data so the UI will have something to shimmer
    private func mockLoadingData() -> [Appointment] {
        return [
            Appointment.mocked(),
            Appointment.mocked(),
            Appointment.mocked(),
            Appointment.mocked(),
            Appointment.mocked(),
            Appointment.mocked()
        ]
    }
}
