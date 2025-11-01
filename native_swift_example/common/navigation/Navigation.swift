import Foundation

// Equivalent to HomeScreenRoute object
enum HomeScreenRoute: Codable, Hashable {
    case home
}

// Equivalent to DetailsScreenRoute data class
enum DetailsScreenRoute: Codable, Hashable {
    case details(id: String)
}

// Or you could combine them into a single navigation enum
enum NavigationRoute: Codable, Hashable {
    case home
    case details(id: String)
}
