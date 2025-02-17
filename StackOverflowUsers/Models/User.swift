/// User model that contains all properties to be displayed in the app
struct User: Codable, Identifiable {
    let userId: Int
    let displayName: String
    let profileImage: String
    let reputation: Int
    
    var id: Int { userId }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case displayName = "display_name"
        case profileImage = "profile_image"
        case reputation = "reputation"
    }
}
