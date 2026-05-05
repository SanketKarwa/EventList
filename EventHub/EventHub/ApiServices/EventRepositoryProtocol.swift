//
//  EventRepositoryProtocol.swift
//  EventHub
//
//  Created by Sanket Karwa on 04/05/26.
//
import Foundation
import Combine

protocol EventRepositoryProtocol {
    func getEvents() -> AnyPublisher<[Event], Error>
    func toggleBookmark(event: Event)
    func isEventBookmarked(event: Event) -> Bool
    func distance(to event: Event) -> String
    func navigateUsingMap(event: Event)
}
