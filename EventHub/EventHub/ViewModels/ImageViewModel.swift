//
//  ImageViewModel.swift
//  EventHub
//
//  Created by Sanket Karwa on 04/05/26.
//
import Foundation
import UIKit
import Combine

class ImageCache {
    static let shared = NSCache<NSURL, UIImage>()
}

class ImageViewModel: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?

    func load(from url: URL?) {
        guard let url = url else { return }
        if let cached = ImageCache.shared.object(forKey: url as NSURL) {
            print("cached")
            self.image = cached
            return
        }
        if image != nil { return }
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveOutput: { image in
                if let image = image {
                    ImageCache.shared.setObject(image, forKey: url as NSURL)
                }
            })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                print("downloaded")
                self?.image = image
            }
    }
}
