//
//  ApiServiceProtocol.swift
//  EventHub
//
//  Created by Sanket Karwa on 04/05/26.
//
import Foundation
import Combine

protocol ApiServiceProtocol {
    func fetchEvents() -> AnyPublisher<[Event], Error>
}
