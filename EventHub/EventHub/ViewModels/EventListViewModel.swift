//
//  EventListViewModel.swift
//  EventHub
//
//  Created by Sanket Karwa on 04/05/26.
//
import Combine
import CoreLocation

class EventListViewModel: ObservableObject {
    @Published var events: [Event] = []
    @Published var errorString: String?
    @Published var showLoadingIndicator: Bool = false
    private let repository: EventRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    init(repository: EventRepository) {
        self.repository = repository
        loadEvents()
    }

    func loadEvents() {
        showLoadingIndicator = true
        errorString = nil
        repository.getEvents()
            .sink(receiveCompletion: {completion in
                self.showLoadingIndicator = false
                switch completion {
                case .finished: print("Finished")
                case .failure(let error):
                    print("Error \(error.localizedDescription)")
                    self.errorString = error.localizedDescription
                }
            }, receiveValue: { event in
                self.events = event
            })
            .store(in: &cancellables)
    }

    func toggleBookmark(event: Event) {
        repository.toggleBookmark(event: event)
        loadEvents()
    }

    func isEventBookmarked(event: Event) -> Bool {
        return repository.isEventBookmarked(event: event)
    }

    func distance(to event: Event) -> String {
        return repository.distance(to: event)
    }

    func navigateUsingMap(event: Event) {
        repository.navigateUsingMap(event: event)
    }
}
