import Foundation

/// Repository class for managing Landmark data.
/// In a real application, this would interface with a database or network layer.
@MainActor
class LandmarkRepository: ObservableObject {
    /// In-memory list of landmarks acting as a data source.
    @Published private var _landmarks: [Landmark] = [
        Landmark(
            id: "1",
            name: "Eiffel Tower",
            description: "An iron lattice tower in Paris"
        ),
        Landmark(
            id: "2",
            name: "Colosseum",
            description: "An ancient amphitheater in Rome"
        ),
        Landmark(
            id: "3",
            name: "Great Wall of China",
            description: "A series of fortifications in northern China"
        )
    ]
    
    /// Gets the list of all landmarks. (part of R in CRUD)
    ///
    /// Simulates a network or database delay.
    ///
    /// Highlights the use of async functions for asynchronous operations.
    func getLandmarks() async throws -> [Landmark] {
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second delay
        return _landmarks
    }
    
    /// Gets a landmark by its ID. (part of R in CRUD)
    func getLandmarkById(_ id: String) -> Landmark? {
        return _landmarks.first { $0.id == id }
    }
    
    /// Adds a new landmark. (part of C in CRUD)
    func addLandmark(name: String, description: String) {
        let newLandmark = Landmark(
            id: UUID().uuidString,
            name: name,
            description: description
        )
        _landmarks.append(newLandmark)
    }
    
    /// Deletes a landmark by its ID. (part of D in CRUD)
    func deleteLandmark(_ id: String) {
        _landmarks.removeAll { $0.id == id }
    }
    
    /// Updates an existing landmark. (part of U in CRUD)
    func updateLandmark(id: String, name: String, description: String) {
        if let index = _landmarks.firstIndex(where: { $0.id == id }) {
            _landmarks[index] = Landmark(id: id, name: name, description: description)
        }
    }
}
