//
//  ContentView.swift
//  EventHub
//
//  Created by Sanket Karwa on 04/05/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        EventListView(viewModel: EventListViewModel(
            repository: EventRepository(api: ApiService(),
                                        bookmarkManager: BookmarkManager(),
                                        cache: DiskCacheManager(),
                                        locationManager: LocationManager())))
    }
}
