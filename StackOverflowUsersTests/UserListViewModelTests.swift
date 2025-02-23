import XCTest
@testable import StackOverflowUsers

class UserListViewModelTests: XCTestCase {
    var viewModel: UserListViewModel!
    var mockNetworkService: MockNetworkService!
    var mockUserStore: MockUserStore!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        mockUserStore = MockUserStore()
        viewModel = UserListViewModel(networkService: mockNetworkService, userStore: mockUserStore)
    }
    
    func testLoadUsersSuccess() async {
        let testUser = User(userId: 1, displayName: "Test User", profileImage: "http://example.com/image.jpg", reputation: 1000)
        mockNetworkService.users = [testUser]
        XCTAssertEqual(viewModel.users.count, 0)
        XCTAssertNil(viewModel.error)
        
        await viewModel.loadUsers()
        
        let exp = expectation(description: "Wait for main thread updates")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            exp.fulfill()
        }
        await fulfillment(of: [exp], timeout: 1.0)
        
        XCTAssertEqual(viewModel.users.count, 1)
        XCTAssertEqual(viewModel.users[0].userId, 1)
        XCTAssertNil(viewModel.error)
    }
    
    func testLoadUsersFailure() async {
        mockNetworkService.error = NetworkError.serverError(statusCode: 500)
        
        XCTAssertEqual(viewModel.users.count, 0)
        XCTAssertNil(viewModel.error)
        
        await viewModel.loadUsers()
        
        let exp = expectation(description: "Wait for main thread updates")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            exp.fulfill()
        }
        await fulfillment(of: [exp], timeout: 1.0)
        
        XCTAssertEqual(viewModel.users.count, 0)
        XCTAssertNotNil(viewModel.error)
        if case .serverError(let statusCode) = viewModel.error {
            XCTAssertEqual(statusCode, 500)
        } else {
            XCTFail("Expected serverError but got \(String(describing: viewModel.error))")
        }
    }
    
    func testToggleFollow() {
        let testUserId = 1
        XCTAssertFalse(viewModel.isUserFollowed(userId: testUserId))
        viewModel.toggleFollow(for: testUserId)
        XCTAssertTrue(viewModel.isUserFollowed(userId: testUserId))
        viewModel.toggleFollow(for: testUserId)
        XCTAssertFalse(viewModel.isUserFollowed(userId: testUserId))
    }
}
