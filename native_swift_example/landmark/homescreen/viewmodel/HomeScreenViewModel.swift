import SwiftUI
import Combine

@MainActor
class HomeScreenViewModel: ObservableObject {
    let landmarkRepository: LandmarkRepository
    
    @Published var landmarks: [Landmark] = []
    @Published var shouldShowBottomSheet = false
    @Published var idToDelete: String?
    @Published var isLoading = false
    @Published var isError = false
    
    init(landmarkRepository: LandmarkRepository) {
        self.landmarkRepository = landmarkRepository
        
        // Fetch items on initialization
        Task {
            await getItems()
        }
    }
    
    func getItems() async {
        isLoading = true
        do {
            landmarks = try await landmarkRepository.getLandmarks()
            isError = false
        } catch {
            isError = true
        }
        isLoading = false
    }
    
    func deleteLandmarkById(_ id: String?) {
        guard let id = id else { return }
        landmarkRepository.deleteLandmark(id)
        
        Task {
            await getItems()
        }
    }
    
    func showBottomSheet() {
        shouldShowBottomSheet = true
    }
    
    func hideBottomSheet() {
        shouldShowBottomSheet = false
    }
}

