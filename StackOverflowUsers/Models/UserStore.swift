import Foundation
import SwiftUI

protocol UserStoreProtocol {
    func followUser(userId: Int)
    func unfollowUser(userId: Int)
    func isUserFollowed(userId: Int) -> Bool
}

class UserStore: UserStoreProtocol, ObservableObject {
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
    
    func isUserFollowed(userId: Int) -> Bool {
        return followedUsers.contains(userId)
    }
    
    private func saveFollowedUsers() {
        UserDefaults.standard.set(Array(followedUsers), forKey: followedUsersKey)
    }
}
