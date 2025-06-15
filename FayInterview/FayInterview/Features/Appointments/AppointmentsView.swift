//
//  AppointmentsView.swift
//  FayInterview
//
//  Created by Shawna MacNabb on 6/13/25.
//

import SwiftUI
import Shimmer

struct AppointmentsView: View {

    @StateObject var viewModel: AppointmentsViewModel

    var body: some View {
        VStack(alignment: .leading) {
            switch viewModel.screenState {
            case .loaded, .empty, .loading:
                header
                appointmentsList
            case .error:
                ErrorStateUI(retryAction: viewModel.retry)
            }
        }
        .onAppear {
            viewModel.loadData()
        }
        .background(Color.white) // locking in light mode for now
    }

    @ViewBuilder
    private var header: some View {
        Text(.title3(text: "Fay", fontWeight: .semibold, color: .gray))
            .padding(.vertical, 12)
            .padding(.horizontal, 24)
        Divider()
        Text(.title2(text: "Appointments", fontWeight: .semibold))
            .padding(.bottom, 24)
            .padding(.horizontal, 24)
        ScrollableMenu(
            selection: $viewModel.selectedTab,
            options: AppointmentsViewModel.MenuTab.allCases,
            label: { item in
                Text(.body(text: item.rawValue, color: Color.secondaryAccent))
            }
        )
    }

    @ViewBuilder
    private var appointmentsList: some View {
        if viewModel.isEmpty() && viewModel.screenState != .loading {
            EmptyStateUI(title: "No Appointments", retryAction: viewModel.retry)
        } else {
            List {
                ForEach(viewModel.getDataForSelectedTab()) { item in
                    AppointmentCell(viewModel: AppointmentCellModel(appointment: item))
                        .padding(.bottom, 24)
                        .customListStyle
                        .shimmeringUI(isLoading: viewModel.screenState == .loading)
                }
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            .refreshable {
                viewModel.retry()
            }
        }
    }
}
