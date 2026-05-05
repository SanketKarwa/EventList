//
//  MockTest.swift
//  EventHubUITests
//
//  Created by Sanket Karwa on 04/05/26.
//

import Foundation
import Combine

public class MockAPIService: ApiServiceProtocol {
    var isCalled = false
    var events: [Event] = []
    func fetchEvents() -> AnyPublisher<[Event], Error> {
        isCalled = true
        return Just(events)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
