import Foundation
import SwiftUI


struct UserRow: View {
    let user: User
    let isFollowed: Bool
    let onFollowTapped: () -> Void
    
    @State private var image: UIImage?
    
    var body: some View {
        HStack(spacing: 12) {
            
            ZStack(alignment: .topLeading) {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                }
                
                if isFollowed {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 10, height: 10)
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.displayName)
                    .font(.headline)
                
                Text("Reputation: \(user.reputation)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()

            Button(action: onFollowTapped) {
                Text(isFollowed ? "Unfollow" : "Follow")
                    .font(.system(size: 14, weight: .medium))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(isFollowed ? Color.clear : Color.blue)
                    .foregroundColor(isFollowed ? Color.red : Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isFollowed ? Color.red : Color.clear, lineWidth: 1)
                    )
                    .cornerRadius(8)
            }
        }
        .padding(.vertical, 8)
        .onAppear {
            loadProfileImage()
        }
    }
    
    private func loadProfileImage() {
        guard let url = URL(string: user.profileImage) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let loadedImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = loadedImage
                }
            }
        }.resume()
    }
}
