//
//  ApiService.swift
//  EventHub
//
//  Created by Sanket Karwa on 04/05/26.
//

import Foundation
import Combine

class ApiService: ApiServiceProtocol {
    private let url = Endpoints.shared.allEvents

    func fetchEvents() -> AnyPublisher<[Event], any Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
        .map(\.data)
        .decode(type: [Event].self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
