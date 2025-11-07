import SwiftUI

struct HomeScreen: View {
    @ObservedObject var homeScreenViewModel: HomeScreenViewModel
    @State private var path: [String] = [] // Stack of navigations
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                if homeScreenViewModel.isLoading {
                    Text("Loading...")
                } else if homeScreenViewModel.isError {
                    VStack(spacing: 16) {
                        Text("Error loading landmarks")
                            .foregroundColor(.red)
                        Button("Retry") {
                            Task {
                                await homeScreenViewModel.getItems()
                            }
                        }
                    }
                } else {
                    List(homeScreenViewModel.landmarks) { landmark in
                        LandmarkListItem(landmark: landmark)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                path.append(landmark.id)
                            }
                            .onLongPressGesture {
                                homeScreenViewModel.showBottomSheet()
                                homeScreenViewModel.idToDelete = landmark.id
                            }
                    }
                    .navigationTitle("Homepage")
                    .navigationBarTitleDisplayMode(.large)
                    .navigationDestination(for: String.self) { id in
                        DetailsScreen(landmarkRepository: homeScreenViewModel.landmarkRepository, id: id)
                    }
                }
            }
            .sheet(isPresented: $homeScreenViewModel.shouldShowBottomSheet) {
                VStack(spacing: 20) {
                    Button(action: {
                        homeScreenViewModel.deleteLandmarkById(homeScreenViewModel.idToDelete)
                        homeScreenViewModel.hideBottomSheet()
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
