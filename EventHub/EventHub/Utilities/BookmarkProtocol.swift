//
//  BookmarkProtocol.swift
//  EventHub
//
//  Created by Sanket Karwa on 04/05/26.
//
import Foundation

protocol BookmarkProtocol {
    func saveBookmarks(_ ids: [String])
    func loadBookmarks() -> [String]
}
