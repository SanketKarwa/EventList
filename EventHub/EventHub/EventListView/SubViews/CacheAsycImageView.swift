//
//  CacheAsycImageView.swift
//  EventHub
//
//  Created by Sanket Karwa on 04/05/26.
//
import Foundation
import SwiftUI

struct CachedAsyncImageView: View {
    let event: Event
    @StateObject private var imageViewModel = ImageViewModel()
    var body: some View {
        Group {
            if let image = imageViewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                ProgressView()
            }
        }
        .frame(width: 60, height: 60)
        .clipped()
        .cornerRadius(10)
        .onAppear {
            imageViewModel.load(from: URL(string: event.imageUrl))
        }
    }
}
