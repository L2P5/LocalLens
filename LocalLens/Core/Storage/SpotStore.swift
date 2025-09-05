//
//  SpotStore.swift
//  LocalLens
//
//  Created by Lesandu Perera on 2025-09-05.
//

import Foundation

protocol SpotStore {
    func load() throws -> [SpotBase]
    func save(_ spots: [SpotBase]) throws
}

enum StoreError: LocalizedError {
    case cannotRead, cannotWrite
    var errorDescription: String? {
        switch self {
        case .cannotRead:  return "Couldn’t read saved spots."
        case .cannotWrite: return "Couldn’t save spots."
        }
    }
}
