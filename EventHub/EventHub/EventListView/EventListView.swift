//
//  EventListView.swift
//  EventHub
//
//  Created by Sanket Karwa on 04/05/26.
//
import SwiftUI

struct EventListView: View {
    @StateObject var viewModel: EventListViewModel
    @State private var showMap = false

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.showLoadingIndicator {
                    ProgressView()
                } else if let error = viewModel.errorString {
                    VStack(spacing: 20) {
                        Text(error)
                            .foregroundColor(.red)
                        Button("Try again") {
                            viewModel.loadEvents()
                        }
                    }
                } else {
                    List(viewModel.events) { event in
                        EventCell(
                            event: event,
                            distance: viewModel.distance(to: event),
                            isEventBookmarked: viewModel.isEventBookmarked(event: event)
                        ) {
                            viewModel.toggleBookmark(event: event)
                        }
                        .onTapGesture {
                            viewModel.navigateUsingMap(event: event)
                        }
                    }
                    .listStyle(.plain)
                    .padding(.top, 20)
                    .refreshable {
                        viewModel.loadEvents()
                    }
                }
            }
            .navigationTitle("Nearby Events")
        }
    }
}
