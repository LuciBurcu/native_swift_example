import SwiftUI

struct DetailsScreen: View {
    let landmarkRepository: LandmarkRepository
    let id: String
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        let landmark = landmarkRepository.getLandmarkById(id)

        VStack(alignment: .leading, spacing: 16) {
            Text("Landmark name: \(landmark?.name ?? "Not found")")
            Text("Landmark description: \(landmark?.description ?? "No description")")
            Spacer()
        }
        .padding()
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
            }
        }
    }
}

