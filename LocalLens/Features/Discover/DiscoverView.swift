//
//  DiscoverView.swift
//  LocalLens
//
//  Created by Lesandu Perera on 2025-09-05.
//

import SwiftUI

struct DiscoverView: View {
    @StateObject var vm = DiscoverViewModel()

    var body: some View {
        NavigationStack {
            List(vm.visibleSpots) { spot in
                NavigationLink(spot.name) {
                    SpotDetailView(spot: spot)
                }
            }
            .navigationTitle("Local Lens")
            .searchable(text: $vm.query)
            .onAppear {
                vm.load()
                vm.addSampleIfEmpty()
            }
        }
    }
}
