//
//  EndPoints.swift
//  EventHub
//
//  Created by Sanket Karwa on 04/05/26.
//
import Foundation

final class Endpoints {
    static let shared = Endpoints()
    private init() {}

    private let baseURL = "https://69f84cb8dd0c226688ee62d4.mockapi.io/api/v1"

    var allEvents: URL {
        URL(string: "\(baseURL)/allEvents")!
    }
}
