import Foundation
import SwiftUI


struct UserRow: View {
    let user: User
    
    @State private var image: UIImage?
    
    var body: some View {
        HStack(spacing: 12) {
            
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.displayName)
                    .font(.headline)
                
                Text("Reputation: \(user.reputation)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
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
