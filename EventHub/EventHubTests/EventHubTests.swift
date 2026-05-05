//
//  EventHubTests.swift
//  EventHubTests
//
//  Created by Sanket Karwa on 04/05/26.
//

import Testing
@testable import EventHub
import Foundation
import XCTest

final class EventHubTests: XCTestCase {
    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

    @Test func test_getEvents_returnsCachedData_whenCacheExists() {
        let mockAPI = MockAPIService()
        let repository = EventRepository(api: mockAPI,
                                         bookmarkManager: BookmarkManager(),
                                         cache: DiskCacheManager(),
                                         locationManager: LocationManager())
        let events = [Event(id: "1", title: "Party", location: "NY",
                            latitude: 0, longitude: 0, time: Date(),
                            imageUrl: "")]
        repository.cache.save(events, for: "events", ttl: 300)
        let expectation = XCTestExpectation(description: "Return cached events")
        _ = repository.getEvents()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { result in
                XCTAssertEqual(result.count, 1)
                XCTAssertFalse(mockAPI.isCalled) // ✅ API should NOT be called
                expectation.fulfill()
            })
    }

    @Test func test_localStorage_saveAndLoadEvents() {
        let key = "events"
        let diskCacheManager = DiskCacheManager()
        let events = [
            Event(id: "1", title: "Birthday", location: "Mumbai", latitude: 0, longitude: 0, time: Date(), imageUrl: "")
        ]
        diskCacheManager.save(events, for: key, ttl: 300) // 5 mins TTL
        if let loaded: [Event] = diskCacheManager.load([Event].self, for: key) {
            XCTAssertNotNil(loaded)
            XCTAssertEqual(loaded.first?.id, "1")
        }
    }

    @Test func test_getEvents_callsAPI_whenCacheEmpty() {
        let mockAPI = MockAPIService()
        mockAPI.events = [
            Event(id: "1", title: "Concert", location: "LA", latitude: 0, longitude: 0, time: Date(), imageUrl: "")
        ]
        let repository = EventRepository(api: mockAPI,
                                         bookmarkManager: BookmarkManager(),
                                         cache: DiskCacheManager(),
                                         locationManager: LocationManager())
        let expectation = XCTestExpectation(description: "Fetch from API")
        _ = repository.getEvents()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { result in
                XCTAssertEqual(result.count, 1)
                expectation.fulfill()
            })
        wait(for: [expectation], timeout: 1)
    }
}
