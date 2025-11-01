import SwiftUI

/// A single UI item representing a landmark in a list.
struct LandmarkListItem: View {
    let landmark: Landmark
    
    var body: some View {
        HStack(spacing: 16) {
            // Avatar
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 64, height: 64)
                
                Text(String(landmark.name.first ?? "?"))
                    .font(.largeTitle)
                    .italic()
            }
            
            // Content
            VStack(alignment: .leading, spacing: 4) {
                Text(landmark.name)
                    .font(.body)
                
                Text(landmark.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            
            Spacer()
        }
        .padding(16)
    }
}
