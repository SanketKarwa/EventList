////
////  DiskCacheManager.swift
////  EventHub
////
////  Created by Sanket Karwa on 04/05/26.

import Foundation

struct CacheWrapper<T: Codable>: Codable {
    let data: T
    let expiry: Date
}

public final class DiskCacheManager: DiskCacheProtocol {

    private let directory: URL
    public init(folderName: String = "EventCache") {
        let base = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        self.directory = base.appendingPathComponent(folderName)
        try? FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
    }

    private func fileURL(for key: String) -> URL {
        directory.appendingPathComponent("\(key).json")
    }

    func save<T: Codable>(_ object: T, for key: String, ttl: TimeInterval) {
        let wrapper = CacheWrapper(data: object, expiry: Date().addingTimeInterval(ttl))
        let url = fileURL(for: key)
        do {
            let data = try JSONEncoder().encode(wrapper)
            try data.write(to: url)
        } catch {
            print("Disk save error:", error)
        }
    }

    func load<T: Codable>(_ type: T.Type, for key: String) -> T? {
        let url = fileURL(for: key)
        guard let data = try? Data(contentsOf: url),
              let wrapper = try? JSONDecoder().decode(CacheWrapper<T>.self, from: data)
        else {
            return nil
        }
        if wrapper.expiry > Date() {
            print("Disk cache HIT")
            return wrapper.data
        } else {
            print("Cache expired")
            try? FileManager.default.removeItem(at: url)
            return nil
        }
    }
}
