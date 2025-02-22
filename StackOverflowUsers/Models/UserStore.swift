import Foundation
import SwiftUI

class UserStore: ObservableObject {
    private let followedUsersKey = "followedUsers"
    @Published private var followedUsers: Set<Int>
    
    init() {
        if let savedIds = UserDefaults.standard.array(forKey: followedUsersKey) as? [Int] {
            followedUsers = Set(savedIds)
        } else {
            followedUsers = []
        }
    }
    
    func followUser(userId: Int) {
        followedUsers.insert(userId)
        saveFollowedUsers()
    }
    
    func unfollowUser(userId: Int) {
        followedUsers.remove(userId)
        saveFollowedUsers()
    }
    
    private func saveFollowedUsers() {
        UserDefaults.standard.set(Array(followedUsers), forKey: followedUsersKey)
    }
}
