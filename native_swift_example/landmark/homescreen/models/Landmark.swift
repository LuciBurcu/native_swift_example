import Foundation

/**
 * Base data structure for Landmark data model
 * We use structs to hold data in a structured way and to have access to
 * useful methods like equality comparison and copying.
 */
struct Landmark: Codable, Hashable, Identifiable {
    let id: String
    let name: String
    let description: String
}
