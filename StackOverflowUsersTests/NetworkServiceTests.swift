import XCTest
@testable import StackOverflowUsers

class NetworkServiceTests: XCTestCase {
    func testFetchUsersSuccess() async {
        let mockNetworkService = MockNetworkService()
        let testUser = User(userId: 1, displayName: "Test User", profileImage: "http://example.com/image.jpg", reputation: 1000)
        mockNetworkService.users = [testUser]

        do {
            let users = try await mockNetworkService.fetchUsers()
            XCTAssertEqual(users.count, 1)
            XCTAssertEqual(users[0].userId, 1)
            XCTAssertEqual(users[0].displayName, "Test User")
            XCTAssertEqual(users[0].profileImage, "http://example.com/image.jpg")
            XCTAssertEqual(users[0].reputation, 1000)
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }

    func testFetchUsersFailure() async {
        let mockNetworkService = MockNetworkService()
        mockNetworkService.error = NetworkError.serverError(statusCode: 500)

        do {
            _ = try await mockNetworkService.fetchUsers()
            XCTFail("Expected error but got success")
        } catch let error as NetworkError {
            if case .serverError(let statusCode) = error {
                XCTAssertEqual(statusCode, 500)
            } else {
                XCTFail("Expected serverError but got \(error)")
            }
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
}

class MockNetworkService: NetworkServiceProtocol {
    var users: [User]?
    var error: NetworkError?

    func fetchUsers() async throws -> [User] {
        if let error = error {
            throw error
        }

        return users ?? []
    }
}
