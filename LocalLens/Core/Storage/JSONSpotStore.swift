//
//  JSONSpotStore.swift
//  LocalLens
//
//  Created by Lesandu Perera on 2025-09-05.
//

import Foundation

final class JSONSpotStore: SpotStore {
    private let url: URL

    init(filename: String = "spots.json") {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        self.url = dir.appendingPathComponent(filename)
    }

    func load() throws -> [SpotBase] {
        guard FileManager.default.fileExists(atPath: url.path) else { return [] }
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try decoder.decode([SpotBase].self, from: data)
    }

    func save(_ spots: [SpotBase]) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(spots)
        do {
            try data.write(to: url, options: .atomic)
        } catch {
            throw StoreError.cannotWrite
        }
    }
}
