//
//  DiscoverViewModel.swift
//  LocalLens
//
//  Created by Lesandu Perera on 2025-09-05.
//

import Foundation

@MainActor
final class DiscoverViewModel: ObservableObject {
    @Published private(set) var spots: [SpotBase] = []
    @Published var query: String = ""

    private let store: SpotStore

    init(store: SpotStore = JSONSpotStore()) {
        self.store = store
    }

    func load() {
        do { spots = try store.load() }
        catch { spots = [] } // later: show alert
    }

    func addSampleIfEmpty() {
        guard spots.isEmpty else { return }
        spots = [
            UserAddedSpot(name: "Street Art – Newtown", latitude: -33.897, longitude: 151.179, categories: [.streetArt], notes: "Lane mural"),
            UserAddedSpot(name: "Barangaroo Lookout", latitude: -33.866, longitude: 151.201, categories: [.viewpoint], notes: "Best at sunset")
        ]
        persist()
    }

    var visibleSpots: [SpotBase] {
        if query.isEmpty { return spots }
        return spots.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }

    func persist() {
        do { try store.save(spots) } catch { /* later: alert */ }
    }
}
