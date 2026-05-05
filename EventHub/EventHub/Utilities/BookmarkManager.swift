//
//  BookmarkManager.swift
//  EventHub
//
//  Created by Sanket Karwa on 04/05/26.
//
import Foundation
public class BookmarkManager: BookmarkProtocol {
    private let bookmarksKey = "bookmarked_events"

    public init() {}
    func saveBookmarks(_ ids: [String]) {
        UserDefaults.standard.set(ids, forKey: bookmarksKey)
    }

    func loadBookmarks() -> [String] {
        UserDefaults.standard.stringArray(forKey: bookmarksKey) ?? []
    }
}
