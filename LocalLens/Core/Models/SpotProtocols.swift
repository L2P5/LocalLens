//
//  SpotProtocols.swift
//  LocalLens
//
//  Created by Lesandu Perera on 2025-09-05.
//

import Foundation
import CoreLocation

// MARK: - Protocol for all spots
protocol Spotable: Identifiable, Codable {
    var id: UUID { get }
    var name: String { get set }
    var latitude: Double { get set }
    var longitude: Double { get set }
    var categories: [SpotCategory] { get set }
    var notes: String? { get set }
    func validate() throws
}

// MARK: - Categories
enum SpotCategory: String, CaseIterable, Codable {
    case streetArt = "Street Art"
    case cafe = "Café"
    case viewpoint = "Viewpoint"
    case park = "Park"
    case landmark = "Landmark"
    case custom = "Custom"
}

// MARK: - Errors
enum SpotError: LocalizedError {
    case emptyName
    case invalidCoordinates

    var errorDescription: String? {
        switch self {
        case .emptyName: return "Spot name can’t be empty."
        case .invalidCoordinates: return "Invalid coordinates."
        }
    }
}

// MARK: - Default Validation
extension Spotable {
    func validate() throws {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw SpotError.emptyName
        }
        let coord = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        if !CLLocationCoordinate2DIsValid(coord) {
            throw SpotError.invalidCoordinates
        }
    }
}
