//
//  EventRepository.swift
//  EventHub
//
//  Created by Sanket Karwa on 04/05/26.
//
import Combine
import CoreLocation
import UIKit

class EventRepository: EventRepositoryProtocol {
    private let api: ApiServiceProtocol
    let bookmarkManager: BookmarkProtocol
    let cache: DiskCacheProtocol
    let locationManager: LocationManager

    init(api: ApiServiceProtocol, bookmarkManager: BookmarkProtocol,
         cache: DiskCacheProtocol, locationManager: LocationManager) {
        self.api = api
        self.bookmarkManager = bookmarkManager
        self.cache = cache
        self.locationManager = locationManager
    }

    func getEvents() -> AnyPublisher<[Event], Error> {
        let key = "events"
        if let cached: [Event] = cache.load([Event].self, for: key) {
            print("Returning from cache")
            return Just(cached)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        guard NetworkMonitor.shared.isConnected else {
            return Fail(error: URLError(.notConnectedToInternet))
                .eraseToAnyPublisher()
          }
        print("Fetching from API")
        return api.fetchEvents()
            .handleEvents(receiveOutput: { [weak self] events in
                self?.cache.save(events, for: key, ttl: 300) // 5 mins TTL
            })
            .eraseToAnyPublisher()
    }

    func toggleBookmark(event: Event) {
        var bookmarks = bookmarkManager.loadBookmarks()
        if bookmarks.contains(event.id) {
            bookmarks.removeAll { $0 == event.id }
        } else {
            bookmarks.append(event.id)
        }
        bookmarkManager.saveBookmarks(bookmarks)
    }

    func isEventBookmarked(event: Event) -> Bool {
        let bookmarks = bookmarkManager.loadBookmarks()
        return bookmarks.contains(event.id)
    }

    func distance(to event: Event) -> String {
        let defaultLocation = CLLocation(latitude: 37.7514, longitude: -122.4138)
        let userLoc = locationManager.location ?? defaultLocation
        let eventLoc = CLLocation(latitude: event.latitude, longitude: event.longitude)
        let distanceInMeters = userLoc.distance(from: eventLoc)
        let distanceInKm = distanceInMeters / 1000
        return String(format: "%.1f km", distanceInKm)
    }

    func navigateUsingMap(event: Event) {
        let userLat = String(describing: locationManager.location?.coordinate.latitude)
        let userLong = String(describing: locationManager.location?.coordinate.longitude)
        let eventLat = event.latitude
        let eventLong = event.longitude
        let url = URL(string: "http://maps.apple.com/?saddr=\(userLat),\(userLong))&daddr=\(eventLat),\(eventLong)")!
        UIApplication.shared.open(url)
    }
}
