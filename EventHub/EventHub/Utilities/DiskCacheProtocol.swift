//
//  DiskCacheProtocol.swift
//  EventHub
//
//  Created by Sanket Karwa on 04/05/26.
//

import Foundation

protocol DiskCacheProtocol {
    func save<T: Codable>(_ object: T, for key: String, ttl: TimeInterval)
    func load<T: Codable>(_ type: T.Type, for key: String) -> T?
}
