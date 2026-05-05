//
//  EventCell.swift
//  EventHub
//
//  Created by Sanket Karwa on 04/05/26.
//
import SwiftUI

struct EventCell: View {
    let event: Event
    let distance: String
    let isEventBookmarked: Bool
    let onBookmark: () -> Void
    var body: some View {
        HStack {
            CachedAsyncImageView(event: event)
            VStack(alignment: .leading) {
                Text(event.title)
                Text(distance).font(.caption)
            }
            Spacer()
            Button(action: onBookmark) {
                Image(systemName: isEventBookmarked ? "bookmark.fill" : "bookmark")
            }
            .buttonStyle(.borderless)
            .foregroundColor(.black)
        }
    }
}
