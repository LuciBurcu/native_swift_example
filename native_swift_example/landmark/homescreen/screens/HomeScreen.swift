import SwiftUI

struct HomeScreen: View {
    @ObservedObject var landmarkRepository: LandmarkRepository
    @State private var landmarks: [Landmark] = []
    @State private var path: [String] = [] // Stack of navigations
    
    // Sheet state
    @State private var shouldShowBottomSheet = false
    @State private var idToDelete: String?
    
    var body: some View {
        NavigationStack(path: $path) {
            List(landmarks) { landmark in
                LandmarkListItem(landmark: landmark)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        // Tap gesture is handled by the NavigationStack, we need to add the path
                        path.append(landmark.id)
                    }
                    .onLongPressGesture {
                        shouldShowBottomSheet = true
                        idToDelete = landmark.id
                    }
            }
            .navigationTitle("Homepage")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: String.self) { id in
                DetailsScreen(landmarkRepository: landmarkRepository, id: id)
            }
            .onAppear {
                landmarks = landmarkRepository.getLandmarks()
            }
            // Bottom sheet for delete action
            .sheet(isPresented: $shouldShowBottomSheet) {
                VStack(spacing: 20) {
                    Button(action: {
                        if let id = idToDelete {
                            landmarkRepository.deleteLandmark(id: id)
                            landmarks = landmarkRepository.getLandmarks()
                        }
                        shouldShowBottomSheet = false
                    }) {
                        Text("Delete Landmark")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(8)
                    }
                    .padding()
                }
                .presentationDetents([.fraction(0.2)])
            }
        }
    }
}
