//
//  Untitled.swift
//  EventHub
//
//  Created by Sanket Karwa on 04/05/26.
//

import Foundation
import CoreLocation

struct Event: Identifiable, Codable {
    public let id: String
    public let title: String
    public let location: String
    public let latitude: Double
    public let longitude: Double
    public let time: Date
    public let imageUrl: String

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
