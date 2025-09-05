//
//  SpotModels.swift
//  LocalLens
//
//  Created by Lesandu Perera on 2025-09-05.
//

import Foundation

// MARK: - Base class conforming to Spotable
class SpotBase: Spotable {
    let id: UUID
    var name: String
    var latitude: Double
    var longitude: Double
    var categories: [SpotCategory]
    var notes: String?

    // MARK: - Designated Initializer
    init(id: UUID = UUID(),
         name: String,
         latitude: Double,
         longitude: Double,
         categories: [SpotCategory] = [],
         notes: String? = nil) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.categories = categories
        self.notes = notes
    }

    // MARK: - Codable Initializer (moved inside class)
    required convenience init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        self.init(
            id: try c.decode(UUID.self, forKey: .id),
            name: try c.decode(String.self, forKey: .name),
            latitude: try c.decode(Double.self, forKey: .latitude),
            longitude: try c.decode(Double.self, forKey: .longitude),
            categories: try c.decode([SpotCategory].self, forKey: .categories),
            notes: try c.decodeIfPresent(String.self, forKey: .notes)
        )
    }

    // MARK: - Codable Encoder
    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encode(id, forKey: .id)
        try c.encode(name, forKey: .name)
        try c.encode(latitude, forKey: .latitude)
        try c.encode(longitude, forKey: .longitude)
        try c.encode(categories, forKey: .categories)
        try c.encodeIfPresent(notes, forKey: .notes)
    }

    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case id, name, latitude, longitude, categories, notes
    }
}

// Example subtype (we’ll use this later)
final class UserAddedSpot: SpotBase {}

