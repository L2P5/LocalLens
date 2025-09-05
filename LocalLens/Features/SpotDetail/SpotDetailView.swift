//
//  SpotDetailView.swift
//  LocalLens
//
//  Created by Lesandu Perera on 2025-09-05.
//

import SwiftUI

struct SpotDetailView: View {
    let spot: SpotBase
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(spot.name).font(.title2).bold()
            Text(spot.categories.map { $0.rawValue }.joined(separator: ", "))
                .foregroundStyle(.secondary)
            Text("Lat: \(spot.latitude), Lng: \(spot.longitude)")
                .font(.footnote)
            if let n = spot.notes, !n.isEmpty {
                Text(n)
            } else {
                Text("No notes").foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Spot")
        .navigationBarTitleDisplayMode(.inline)
    }
}
