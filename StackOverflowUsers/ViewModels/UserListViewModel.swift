import SwiftUI

class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var error: NetworkError?
    
    private let networkService: NetworkServiceProtocol
    private let userStore: UserStore
    
    init(networkService: NetworkServiceProtocol = NetworkService(),
         userStore: UserStore = UserStore()) {
        self.networkService = networkService
        self.userStore = userStore
    }
    
    func loadUsers() async {
        DispatchQueue.main.async {
            self.error = nil
        }
        
        do {
            let fetchedUsers = try await networkService.fetchUsers()
            DispatchQueue.main.async {
                self.users = fetchedUsers
            }
        } catch let error as NetworkError {
            DispatchQueue.main.async {
                self.error = error
            }
        } catch {
            DispatchQueue.main.async {
                self.error = .noData
            }
        }
    }

    func isUserFollowed(userId: Int) -> Bool {
        return userStore.isUserFollowed(userId: userId)
    }

    func toggleFollow(for userId: Int) {
        if isUserFollowed(userId: userId) {
            userStore.unfollowUser(userId: userId)
        } else {
            userStore.followUser(userId: userId)
        }
        objectWillChange.send()
    }
}
