import XCTest
@testable import StackOverflowUsers

class UserStoreTests: XCTestCase {
    var userStore: UserStore!
    let testUserId = 12345
    
    override func setUp() {
        super.setUp()
        userStore = UserStore()
        UserDefaults.standard.removeObject(forKey: "followedUsers")
    }
    
    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: "followedUsers")
        super.tearDown()
    }
    
    func testFollowUser() {
        XCTAssertFalse(userStore.isUserFollowed(userId: testUserId))
        userStore.followUser(userId: testUserId)
        XCTAssertTrue(userStore.isUserFollowed(userId: testUserId))
    }
    
    func testUnfollowUser() {
        userStore.followUser(userId: testUserId)
        XCTAssertTrue(userStore.isUserFollowed(userId: testUserId))
        userStore.unfollowUser(userId: testUserId)
        XCTAssertFalse(userStore.isUserFollowed(userId: testUserId))
    }
    
    func testPersistenceAcrossSessions() {
        userStore.followUser(userId: testUserId)
        let newUserStore = UserStore()
        XCTAssertTrue(newUserStore.isUserFollowed(userId: testUserId))
    }
}

class MockUserStore: UserStoreProtocol {
    private var followedUsers: Set<Int> = []
    
    func followUser(userId: Int) {
        followedUsers.insert(userId)
    }
    
    func unfollowUser(userId: Int) {
        followedUsers.remove(userId)
    }
    
    func isUserFollowed(userId: Int) -> Bool {
        return followedUsers.contains(userId)
    }
}
